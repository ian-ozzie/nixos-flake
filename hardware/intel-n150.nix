{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.hardware.intel-n150;
in
{
  options.site.hardware.intel-n150 = {
    enable = lib.mkEnableOption "hardware handling for Intel N150 board ";
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
          "xhci_pci"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      lm_sensors
    ];

    hardware = {
      cpu.intel.updateMicrocode = true;
      enableAllFirmware = true;
    };

    nixpkgs = {
      hostPlatform = "x86_64-linux";
    };

    services = {
      fwupd.enable = true;
    };
  };
}
