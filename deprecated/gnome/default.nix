# modules I don't daily drive, bundled here so that they are still validated
{
  ozzie-workstation,
  ...
}:
{
  system = "x86_64-linux";

  modules = [
    ozzie-workstation.nixosModules.gnome

    {
      system.stateVersion = "24.05";

      boot = {
        extraModulePackages = [ ];
        kernelModules = [ "kvm-amd" ];

        initrd = {
          kernelModules = [ ];

          availableKernelModules = [
            "nvme"
            "sd_mod"
            "thunderbolt"
            "usb_storage"
            "xhci_pci"
          ];
        };

        loader = {
          efi.canTouchEfiVariables = true;

          systemd-boot = {
            enable = true;
          };
        };
      };

      fileSystems = {
        "/" = {
          device = "/dev/nvme0n1p2";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/nvme0n1p1";
          fsType = "vfat";

          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };

      services.openssh = {
        enable = true;
        settings.AllowUsers = [ "root" ];
      };
    }
  ];
}
