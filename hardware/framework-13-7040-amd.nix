{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.hardware.framework-13-7040-amd;
in
{
  options.site.hardware.framework-13-7040-amd = {
    enable = lib.mkEnableOption "hardware handling for Framework 13 w/ AMD Ryzen 5 7640U w/ Radeon 760M Graphics";
  };

  config = lib.mkIf cfg.enable {
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
      clinfo
      glxinfo
      lm_sensors
      nvtopPackages.amd
      powertop
      vulkan-tools
    ];

    hardware = {
      bluetooth.enable = true;
      cpu.amd.updateMicrocode = true;
      enableAllFirmware = true;
      pulseaudio.enable = false;

      opengl = {
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [ amdvlk ];
        extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
      };
    };

    networking.networkmanager = {
      dns = "systemd-resolved";
      enable = true;
    };

    services.pipewire = {
      alsa.enable = true;
      enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };
}
