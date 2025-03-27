{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.hardware.apple-imac-19-1;
in
{
  options.site.hardware.apple-imac-19-1 = {
    enable = lib.mkEnableOption "hardware handling for an early 2019 iMac";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    boot = {
      initrd = {
        availableKernelModules = [
          "ahci"
          "nvme"
          "sd_mod"
          "sdhci_pci"
          "usb_storage"
          "usbhid"
          "xhci_pci"
        ];
        kernelModules = [ ];
      };

      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [ ];
    };

    environment.systemPackages = with pkgs; [
      gpu-viewer
    ];

    hardware = {
      bluetooth.enable = true;
      cpu.intel.updateMicrocode = true;
      enableAllFirmware = true;
    };

    nixpkgs = {
      hostPlatform = "x86_64-linux";
    };

    services = {
      fwupd.enable = true;

      pipewire = {
        alsa.enable = true;
        enable = true;
        jack.enable = true;
        pulse.enable = true;
      };
    };
  };
}
