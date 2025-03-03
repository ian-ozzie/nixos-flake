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
  config = lib.mkIf cfg.work {
    home-manager.users.ozzie = {
      home.packages = with pkgs; [
        google-chrome
        slack
      ];
    };
  };
}
