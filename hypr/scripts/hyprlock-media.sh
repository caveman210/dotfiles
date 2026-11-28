#!/usr/bin/env bash
set -euo pipefail
export path="$home/.nix-profile/bin:/run/current-system/sw/bin:$path"

mode="${1:---title}"
art_link="/tmp/hyprlock-art.png"
empty_png="/tmp/hyprlock-empty.png"

ensure_empty_png() {
    if [[ ! -f "$empty_png" ]]; then
        magick -size 1x1 xc:none "$empty_png" 2>/dev/null || true
    fi
}

pick_player() {
    local players p status
    players=$(busctl --user list --no-legend 2>/dev/null | awk '/^org\.mpris\.mediaplayer2\./ {print $1}')
    for p in $players; do
        status=$(busctl --user get-property "$p" /org/mpris/mediaplayer2 org.mpris.mediaplayer2.player playbackstatus 2>/dev/null | awk -f'"' '{print $2}')
        if [[ "$status" == "playing" ]]; then
            echo "$p"
            return 0
        fi
    done
    return 1
}

player=$(pick_player || true)
if [[ -z "$player" ]]; then
    if [[ "$mode" == "--art" ]]; then
        ensure_empty_png
        echo "$empty_png"
    fi
    exit 0
fi

meta_json=$(busctl --user get-property --json=short "$player" /org/mpris/mediaplayer2 org.mpris.mediaplayer2.player metadata 2>/dev/null || echo "{}")

case "$mode" in
    --title)
        title=$(echo "$meta_json" | jq -r '.data["xesam:title"].data // empty' 2>/dev/null)
        if [[ -n "$title" ]]; then
            if [[ ${#title} -gt 28 ]]; then
                title="${title:0:25}..."
            fi
            echo "$title"
        fi
        ;;
    --artist)
        artist=$(echo "$meta_json" | jq -r '.data["xesam:artist"].data[0] // empty' 2>/dev/null)
        status=$(busctl --user get-property "$player" /org/mpris/mediaplayer2 org.mpris.mediaplayer2.player playbackstatus 2>/dev/null | awk -f'"' '{print $2}')
        icon="󰏤"
        [[ "$status" == "playing" ]] && icon="󰐊"
        if [[ -n "$artist" ]]; then
            line="$icon  $artist"
            if [[ ${#line} -gt 28 ]]; then
                line="${line:0:25}..."
            fi
            echo "$line"
        fi
        ;;
    --art)
        art_url=$(echo "$meta_json" | jq -r '.data["mpris:arturl"].data // empty' 2>/dev/null)
        src_file=""
        if [[ "$art_url" == file:* ]]; then
            path="${art_url#file:}"
            path="${path#//}"
            [[ -f "$path" ]] && src_file="$path"
        elif [[ "$art_url" == http://* || "$art_url" == https://* ]]; then
            url_hash=$(printf '%s' "$art_url" | sha256sum | awk '{print $1}')
            cached="/tmp/hyprlock-art-${url_hash}.img"
            if [[ ! -s "$cached" ]]; then
                rm -f /tmp/hyprlock-art-*.img 2>/dev/null || true
                curl -fssl --max-time 3 "$art_url" -o "$cached" 2>/dev/null || true
            fi
            [[ -s "$cached" ]] && src_file="$cached"
        fi

        if [[ -n "$src_file" ]]; then
            magick "$src_file" -resize 128x128^ -gravity center -extent 128x128 "png32:$art_link" 2>/dev/null || cp -f "$src_file" "$art_link"
            echo "$art_link"
            exit 0
        fi

        ensure_empty_png
        echo "$empty_png"
        ;;
esac
