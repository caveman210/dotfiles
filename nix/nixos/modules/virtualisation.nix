{pkgs, ...}: {
  virtualisation = {
    containers = {
      enable = true;
      registries.settings = {
        "unqualified-search-registries" = ["docker.io"];
      };
    };

    waydroid = {
      enable = false;
      package = pkgs.waydroid-nftables;
    };

    podman = {
      enable = true;
      dockerCompat = true;
    };

    libvirtd = {
      enable = false;
    };
  };
}
