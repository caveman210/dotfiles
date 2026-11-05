# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/packettracer.nix
    ./modules/power.nix
  ];

  # Bootloader.
  boot = {
    supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;
      # grub.enable = false;
      systemd-boot.enable = true;
      # refind.enable = true;
      # refind.package = pkgs.refind;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking = {
    hostName = "nixpad";
    wireless.enable = true;
    networkmanager.enable = true;
    firewall.checkReversePath = false;
  };

  hardware = {
    graphics = {
      enable = true;
      #enable32Bit = true;
    };

    amdgpu = {
      initrd.enable = true;
      #zluda.enable = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    model = "pc105"; # Standard layout map that includes laptop keys
    variant = "";
  };
  services.xserver.videoDrivers = ["amdgpu"];

  virtualisation = {
    containers.enable = true;
    containers.registries.settings = {
      "unqualified-search-registries" = ["docker.io"];
    };

    waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };

    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."caveman" = {
    isNormalUser = true;
    description = "caveman";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "render" "lxc"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Graphics and display utilities
      mesa-demos
      xwayland-satellite

      # VPN and network security
      proton-vpn
      wireguard-tools
      macchanger

      # System monitoring and information
      btop
      fastfetch

      # Bluetooth management
      bluez
      bluetuith

      # Audio management
      pipewire
      wireplumber

      # Hardware control
      brightnessctl

      # Package management
      nh

      # Archive utilities
      unzip

      # Development tools and build systems
      gnumake
      fuse-overlayfs
      passt
      podman-compose
      libarchive
      android-tools

      # Shell customization
      starship

      # Terminal utilities
      bat
      eza
      fzf
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only # General fallback icons set
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.niri.enable = true;
  programs.zsh.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Display Manager Setup
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # System-wide qylock module configuration
  programs.qylock = {
    enable = true;
    theme = "sword";

    themeOptions = {
      terraria.backgroundMode = "time";
      Genshin.backgroundMode = "time";
      clockwork.orbital = {
        themeMode = "dark";
        enableWindup = true;
      };
      osu.gameMode = "menu";
      sddm.enable = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    vim
    wl-clipboard
  ];

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

  # virtualisation.docker.enable = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
