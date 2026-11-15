{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  programs.niri.enable = true;
  programs.zsh.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  environment.systemPackages = with pkgs; [
    kitty
    neovim
    vim
    wl-clipboard
    sbctl
    # libvirt
    (pkgs.writeShellScriptBin "qjackctl" ''
      exec ${pkgs.pipewire.jack}/bin/pw-jack ${pkgs.qjackctl}/bin/qjackctl "$@"
    '')
  ];
}
