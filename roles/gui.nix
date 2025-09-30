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
    networking.networkmanager = {
      dns = "systemd-resolved";
      enable = true;
    };

    ozzie = {
      workstation = {
        starship.enable = true;
      };
    };

    programs = {
      ssh.startAgent = true;

      nvf = {
        settings.vim.clipboard.providers.wl-copy.enable = true;
      };
    };

    users.users = {
      ozzie.extraGroups = [
        "input"
        "networkmanager"
      ];
    };
  };
}
