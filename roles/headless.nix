{
  config,
  lib,
  ...
}:
let
  cfg = config.site.roles.headless;
in
{
  options.site.roles.headless = {
    enable = lib.mkEnableOption "headless role";
  };

  config = lib.mkIf cfg.enable {
    ozzie = {
      workstation = {
        nvf.clipboard = false;
        preset = "tokyo-night";
        starship.enable = true;
      };
    };
  };
}
