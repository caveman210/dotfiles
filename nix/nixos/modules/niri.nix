{pkgs, ...}: {
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    hyprsunset
    kitty
    wl-clipboard
  ];
}
