{
  config,
  lib,
  ...
}:
let
  cfg = config.site.roles.desktop;
in
{
  options.site.roles.desktop = {
    enable = lib.mkEnableOption "desktop role";
  };

  config = lib.mkIf cfg.enable {
    site.roles.gui.enable = true;
  };
}
