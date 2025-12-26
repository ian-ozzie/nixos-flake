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
        nvf.clipboard = true;
        preset = "catppuccin-mocha";
        starship.enable = true;
      };
    };

    programs = {
      direnv.enable = true;
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
