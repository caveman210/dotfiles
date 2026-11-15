# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ ... }: {
  imports = [
    ./hardware-configuration.nix

    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/greetd.nix
    ./modules/hardware.nix
    ./modules/i18n.nix
    ./modules/network.nix
    ./modules/nix.nix
    # ./modules/packettracer.nix
    ./modules/power.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/virtualisation.nix
    # ./modules/qemu.nix
    # ./modules/qylock.nix
  ];

  system.stateVersion = "26.05";
}
