{
  config,
  lib,
  ...
}:
let
  cfg = config.site.hardware.keychron-q3;
in
{
  options.site.hardware.keychron-q3 = {
    enable = lib.mkEnableOption "hardware handling for Keychron Q3";
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      keyboard.qmk.enable = true;
    };
  };
}
