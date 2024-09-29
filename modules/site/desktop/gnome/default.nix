{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.site.desktop.gnome;
in
  with lib; {
    options.site.desktop.gnome.enable = mkOption {
      type = with types; bool;
      default = false;
      description = "Whether to set up gnome";
    };

    config = mkIf cfg.enable {
      services = {
        xserver = {
          enable = true;
          displayManager.gdm.enable = true;
          desktopManager.gnome.enable = true;
        };
      };

      users.users.ozzie.extraGroups = ["networkmanager"];

      fonts = {
        enableDefaultPackages = true;
        fontDir.enable = true;
        packages = with pkgs; [
          nerdfonts
        ];
      };

      services = {
        thermald.enable = true;
        uptimed.enable = true;
      };
    };
}
