{ ... }: {
  hardware = {
    graphics = {
      enable = true;
      # enable32Bit = true;
    };

    amdgpu = {
      initrd.enable = true;
      # zluda.enable = true;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  services.xserver.videoDrivers = ["amdgpu"];
}
