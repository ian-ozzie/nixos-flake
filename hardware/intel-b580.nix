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

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
          vpl-gpu-rt
        ];
      };
    };
  };
}
