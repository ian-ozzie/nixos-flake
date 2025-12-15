{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.hardware.framework-desktop-amd-ai-max-300-series;
in
{
  options.site.hardware.framework-desktop-amd-ai-max-300-series = {
    enable = lib.mkEnableOption "hardware handling for Framework Desktop w/ AMD RYZEN AI MAX+ 395 w/ Radeon 8060S";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

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
    };

    environment.systemPackages = with pkgs; [
      framework-tool
      lm_sensors
      nvtopPackages.amd
    ];

    hardware = {
      cpu.amd.updateMicrocode = true;
      enableAllFirmware = true;
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
