{
  config,
  lib,
  ...
}:
let
  cfg = config.site.environment.bl;
in
{
  options.site.environment.bl = {
    enable = lib.mkEnableOption "shared bl configuration";
  };

  config = lib.mkIf cfg.enable {
  };
}
