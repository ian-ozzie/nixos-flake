{
  fileSystems = {
    "/" = {
      device = "nvme/system/root";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/A779-4DF2";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/nix" = {
      device = "nvme/local/nix";
      fsType = "zfs";
    };

    "/home" = {
      device = "nvme/user/home";
      fsType = "zfs";
    };

    "/persist" = {
      device = "nvme/local/persist";
      fsType = "zfs";
    };

    "/docker" = {
      device = "nvme/local/docker";
      fsType = "zfs";
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/12830268-8b7c-4d01-b10d-52c542f0a930";
    }
  ];
}
