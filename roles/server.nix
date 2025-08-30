{
  config,
  lib,
  ...
}:
let
  cfg = config.site.roles.server;
in
{
  options.site.roles.server = {
    enable = lib.mkEnableOption "server role";
  };

  config = lib.mkIf cfg.enable {
    site.roles.headless.enable = true;
  };
}
