{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.ozzie;
in
{
  config = lib.mkIf cfg.games {
    programs.steam = {
      enable = true;
      package = with pkgs; steam;
    };
  };
}
