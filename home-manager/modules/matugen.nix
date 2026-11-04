{ config, pkgs, ... }:
let
  helpers = ../matugen/scripts;

  matugenTheme = pkgs.writeShellApplication {
    name = "matugen-theme";
    runtimeInputs = with pkgs; [ matugen imagemagick python3 jq procps bash ];
    text = ''
      mode="dark"
      scheme="scheme-tonal-spot"
      contrast="0"

      usage() {
        echo "usage: matugen-theme (image PATH | color HEX) [--mode dark|light] [--type SCHEME] [--contrast N]" >&2
        exit 2
      }

      [[ $# -ge 2 ]] || usage
      source_kind="$1"
      target="$2"
      shift 2

      case "$source_kind" in
        image|color) ;;
        *) usage ;;
      esac

      while [[ $# -gt 0 ]]; do
        case "$1" in
          --mode) mode="$2"; shift 2 ;;
          --type) scheme="$2"; shift 2 ;;
          --contrast) contrast="$2"; shift 2 ;;
          *) usage ;;
        esac
      done

      work_image="$target"
      tmp_image=""

      if [[ "$source_kind" == "image" ]]; then
        # matugen only decodes common web formats. Convert raw/HEIC/JXL/
        # SVG/etc. through ImageMagick first so every listed wallpaper
        # can drive the palette.
        case "''${target,,}" in
          *.jpg|*.jpeg|*.jpe|*.png|*.apng|*.webp|*.gif|*.bmp|*.tif|*.tiff) ;;
          *)
            tmp_image="$(mktemp --suffix=.png)"
            trap 'rm -f "$tmp_image"' EXIT
            magick "$target" -resize '3840x2160>' "$tmp_image"
            work_image="$tmp_image"
            ;;
        esac

        matugen image "$work_image" --mode "$mode" --type "$scheme" --contrast "$contrast" --prefer saturation
      else
        matugen color hex "$target" --mode "$mode" --type "$scheme" --contrast "$contrast"
      fi

      # Terminal foregrounds: keep the dark background, fix only the
      # slots that fall below readable contrast.
      if [[ -f "$HOME/.config/kitty/current-theme.conf" ]]; then
        python3 ${helpers}/fix-contrast.py "$HOME/.config/kitty/current-theme.conf"
        pkill -SIGUSR1 kitty 2>/dev/null || true
      fi

      # Zen reads chrome CSS only at startup.
      # bash ${helpers}/reload-zen.sh
    '';
  };

  matugenPreview = pkgs.writeShellApplication {
    name = "matugen-preview";
    runtimeInputs = with pkgs; [ matugen imagemagick jq bash coreutils ];
    text = builtins.readFile (helpers + "/palette-previews.sh");
  };
in
{
  xdg.configFile."matugen/config.toml" = {
    source = ../matugen/config.toml;
    force = true;
  };
  xdg.configFile."matugen/templates" = {
    source = ../matugen/templates;
    force = true;
  };

  home.packages = [
    matugenTheme
    matugenPreview
  ];
}
