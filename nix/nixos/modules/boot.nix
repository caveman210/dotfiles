{pkgs, ...}: {
  # Bootloader configuration
  boot = {
    supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;

      limine = {
        # General Limine options
        enable = true;
        package = pkgs.limine;
        maxGenerations = 10;
        resolution = "1920x1080x32";
        # enableEditor = true;

        # Target platform options
        efiSupport = true;
        # efiInstallAsRemovable = false;
        # biosSupport = false;
        # biosDevice = null; # e.g. "/dev/sda" or "nodev"

        # Verification & installation behavior
        # validateChecksums = false;
        # panicOnChecksumMismatch = false;
        # enrollConfig = false;
        # force = false;

        # Custom commands and raw configuration
        extraConfig = ''
          # Custom global configuration prepended to limine.conf
          VERBOSE=yes
        '';
        extraEntries = ''
          /Windows
              protocol: efi_chainload
              image_path: guid(3fbd83d3-7217-41d8-929d-d15d2e832f79):/EFI/Microsoft/Boot/bootmgfw.efi
        '';
        extraInstallCommands = "";

        # Secure Boot integration
        secureBoot = {
          enable = true;
          sbctl = pkgs.sbctl;
          autoGenerateKeys = false;
          autoEnrollKeys = {
            enable = false;
            extraArgs = [
              "--microsoft"
              "--firmware-builtin"
            ];
          };
        };

        # Files to copy directly into /boot
        additionalFiles = {};

        # Visual theme & wallpaper configuration
        style = {
          wallpaperStyle = "centered"; # Options: "stretch", "centered", "tiled"
          # backdrop = "000000"; # Hex color fill when centered/fitted (RRGGBB)

          # Referenced relative to modules/boot.nix -> ../assets/limine/
          wallpapers = [
            ../assets/limine/nix-dark.png
            ../assets/limine/nix_dark_2.png
            ../assets/limine/wp12329532-nixos-wallpapers.png
            ../assets/limine/wp12329556-nixos-wallpapers.png
            ../assets/limine/picture_2026-10-24_11-23-24.jpg
          ];

          # Menu UI branding and styling
          interface = {
            # branding = "NixOS Boot Manager";
            resolution = "1920x1080";
            helpColor = "00AA00";
            helpColorBright = "55FF55";
            helpHidden = false;
          };

          # Console & terminal styling
          graphicalTerminal = {
            enable = true;
            foreground = "FFFFFF";
            background = "80000000"; # TTRRGGBB format (TT = transparency)
            brightForeground = "FFFFFF";
            brightBackground = "1A1A1A";
            # font = {
            #  scale = "1";
            # };
          };
        };
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
