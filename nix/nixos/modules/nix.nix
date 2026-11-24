{...}: {
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.activationScripts.copyConfigToGit = {
    text = ''
      TARGET_DIR="/home/caveman/.config/nix/nixos"

      mkdir -p "$TARGET_DIR"
      find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -not -name '.git*' -exec rm -rf {} +
      cp -r --remove-destination /etc/nixos/. "$TARGET_DIR/"

      chown -R caveman:users "$TARGET_DIR"
    '';
    deps = [];
  };
}
