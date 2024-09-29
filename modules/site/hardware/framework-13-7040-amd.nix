{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.site.hardware.framework-13-7040-amd;
in
  with lib; {
    options.site.hardware.framework-13-7040-amd.enable = mkOption {
      type = with types; bool;
      default = false;
      description = "Hardware handling for Framework 13";
    };

    config = mkIf cfg.enable {
      nixpkgs = {
        hostPlatform = lib.mkDefault "x86_64-linux";
        config.allowUnfree = true;
      };

      hardware = {
        cpu.amd.updateMicrocode = true;
        opengl = with pkgs; {
          driSupport = true;
          driSupport32Bit = true;
          extraPackages = [amdvlk];
          extraPackages32 = [driversi686Linux.amdvlk];
        };
      };

      environment.systemPackages = with pkgs; [
        vulkan-tools
        clinfo
        glxinfo
        powertop
        nvtopPackages.amd
        lm_sensors
      ];

      networking.networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
        pulseaudio.enable = false;
      };

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        jack.enable = true;
        pulse.enable = true;
      };
    };
  }
