{
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "rpool/local/root";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/5FA7-DBBC";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/nix" = {
      device = "rpool/local/nix";
      fsType = "zfs";
    };

    "/home" = {
      device = "rpool/data/home";
      fsType = "zfs";
    };

    "/data" = {
      device = "/persist";
      fsType = "none";
      options = ["bind"];
    };

    "/persist" = {
      device = "rpool/data/persist";
      fsType = "zfs";
    };
  };

  swapDevices = [{device = "/dev/disk/by-uuid/0f911a72-0d84-4ca5-8796-6a98dce9954d";}];

  boot.initrd.luks.devices.crypt = {
    device = "/dev/disk/by-uuid/34554222-5c09-4676-a02f-b37aaa870830";
    preLVM = true;
  };
}
