{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.hardware.intel-b580;
in
{
  options.site.hardware.intel-b580 = {
    enable = lib.mkEnableOption "hardware handling for Intel Arc B580";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvtopPackages.intel
    ];

    hardware.graphics = {
      enable = true;

      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
        vpl-gpu-rt
      ];
    };
  };
}
