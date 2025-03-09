{
  config,
  lib,
  ...
}:
let
  cfg = config.site.hardware.wooting-80he;
in
{
  options.site.hardware.wooting-80he = {
    enable = lib.mkEnableOption "hardware handling for Wooting 80HE";
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      wooting.enable = false;
    };
  };
}
