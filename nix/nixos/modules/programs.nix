{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };

  programs.gpu-screen-recorder = {
    enable = false;
    ui.enable = false; # For overlay
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
    vim
    wl-clipboard
    sbctl
    # gpu-screen-recorder-gtk    #'deprecated' GTK interface
    # libvirt
    (pkgs.writeShellScriptBin "qjackctl" ''
      exec ${pkgs.pipewire.jack}/bin/pw-jack ${pkgs.qjackctl}/bin/qjackctl "$@"
    '')
  ];
}
