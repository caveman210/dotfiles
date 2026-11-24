{pkgs, ...}: {
  users.users."caveman" = {
    isNormalUser = true;
    description = "caveman";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "render" "lxc" "libvirtd"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Lockscreen
      hyprlock

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
      file

      # Shell customization
      starship

      # Terminal utilities
      bat
      eza
      fzf
    ];
  };
}
