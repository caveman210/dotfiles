#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH"

MODE="${1:---left}"
BIN="$HOME/.config/quickshell/plugins/weather/bin/weather"
CACHE="/tmp/hyprlock-weather.json"

[[ -x "$BIN" ]] || exit 0

if [[ ! -s "$CACHE" ]] || [[ $(( $(date +%s) - $(stat -c %Y "$CACHE" 2>/dev/null || echo 0) )) -gt 300 ]]; then
    "$BIN" > "$CACHE.tmp" 2>/dev/null && mv -f "$CACHE.tmp" "$CACHE" || true
fi

[[ -s "$CACHE" ]] || exit 0

case "$MODE" in
    --left)
        jq -r 'if .success then .temp else empty end' "$CACHE" 2>/dev/null
        ;;
    --cond)
        jq -r 'if .success then .condition else empty end' "$CACHE" 2>/dev/null
        ;;
    --city)
        jq -r 'if .success then .city else empty end' "$CACHE" 2>/dev/null
        ;;
esac
