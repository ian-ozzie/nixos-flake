{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.hardware.intel-i5-13600k;
in
{
  options.site.hardware.intel-i5-13600k = {
    enable = lib.mkEnableOption "hardware handling for 13th Gen Intel(R) Core(TM) i5-13600K";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    boot = {
      extraModulePackages = [ ];
      kernelModules = [ "kvm-intel" ];

      initrd = {
        kernelModules = [ ];
        availableKernelModules = [
          "ahci"
          "nvme"
          "sd_mod"
          "usb_storage"
          "usbhid"
          "xhci_pci"
        ];
      };
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
