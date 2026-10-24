{
  config,
  pkgs,
  nix-index-database,
  ...
}: {
  imports = [
    nix-index-database.homeModules.nix-index
    ./modules/zsh-conf.nix
    ./modules/gtk.nix
    ./modules/git.nix
    ./modules/packettracer.nix
    ./modules/vicinae.nix
    ./modules/zen-browser.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "caveman";
  home.homeDirectory = "/home/caveman";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  xdg.enable = true;
  # targets.genericLinux.enable = true;     # for non-NixOS

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #    echo "Hello, ${config.home.username}!"
    # '')

    # System monitoring and hardware control
    btop
    brightnessctl
    wireplumber

    # Terminal utilities
    starship
    jq
    ripgrep
    fd
    bat
    p7zip
    wl-clipboard

    # Terminal user interface (TUI)
    lazygit
    yazi
    cava
    vicinae
    gammastep

    # Desktop environment and Wayland utilities
    quickshell
    awww
    grim
    slurp
    wl-mirror
    feh
    nautilus

    # Web browsers
    chromium

    # Media and streaming
    vlc
    stremio-service
    discord

    # Torrenting and file synchronization
    qbittorrent
    syncthing

    # Development tools and build systems
    gcc
    gdb
    gnumake
    meson
    ninja
    gh

    # Programming languages and package managers
    python3
    nodejs
    lua
    luarocks

    # Productivity and document management
    obsidian
    libreoffice
    zathura

    # AI and local LLMs
    ollama
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # This will create a copy of 'dotfiles/screenrc' in the Nix store.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #    org.gradle.console=verbose
    #    org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.backupFileExtension = "backup";

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
    # overwriteBackup = true;
  };

  programs.nix-index-database.comma.enable = true;
  programs.nix-index = {
    enable = true;
    package = pkgs.nix-index;
    enableZshIntegration = true;
  };
}
