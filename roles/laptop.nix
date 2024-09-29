{
  config,
  lib,
  ...
}:
let
  cfg = config.site.roles.laptop;
in
{
  options.site.roles.laptop = {
    enable = lib.mkEnableOption "laptop role";
  };

  config = lib.mkIf cfg.enable {
    ozzie.workstation.enable = true;
    users.users.ozzie.extraGroups = [ "networkmanager" ];
  };
}
