{
  config,
  lib,
  ...
}:
let
  cfg = config.site.environment.lab;
in
{
  options.site.environment.lab = {
    enable = lib.mkEnableOption "shared home lab configuration";
  };

  config = lib.mkIf cfg.enable {
  };
}
