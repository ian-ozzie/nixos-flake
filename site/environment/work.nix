{
  config,
  lib,
  ...
}:
let
  cfg = config.site.environment.work;
in
{
  options.site.environment.work = {
    enable = lib.mkEnableOption "shared work configuration";
  };

  config = lib.mkIf cfg.enable {
  };
}
