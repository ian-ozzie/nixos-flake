{
  config,
  lib,
  ...
}:
let
  cfg = config.site.roles.gui;
in
{
  options.site.roles.gui = {
    enable = lib.mkEnableOption "gui role";
  };

  config = lib.mkIf cfg.enable {
    users.users = {
      ozzie.extraGroups = [ "networkmanager" ];
    };
  };
}
