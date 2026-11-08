{pkgs, ...}: {
  # Bootloader.
  boot = {
    supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;
      # grub.enable = false;
      # systemd-boot.enable = true;
      # refind.enable = true;
      # refind.package = pkgs.refind;
      limine = {
        enable = true;
        secureBoot = {
          enable = true;
          sbctl = pkgs.sbctl;
          autoEnrollKeys = {
            enable = false;
            extraArgs = [
              "--microsoft"
              "--firmware-builtin"
            ];
          };
          autoGenerateKeys = false;
        };
        extraEntries = ''
          /Windows
            			protocol: efi_chainload
            			image_path: guid(3fbd83d3-7217-41d8-929d-d15d2e832f79):/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
