{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.hardware.amd-ryzen-7-4750g;
in
{
  options.site.hardware.amd-ryzen-7-4750g = {
    enable = lib.mkEnableOption "hardware handling for AMD Ryzen 7 PRO 4750G with Radeon Graphics";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    boot = {
      extraModulePackages = [ ];
      kernelModules = [ "kvm-amd" ];

      initrd = {
        kernelModules = [ ];
        availableKernelModules = [
          "ahci"
          "mpt3sas"
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
      cpu.amd.updateMicrocode = true;
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
