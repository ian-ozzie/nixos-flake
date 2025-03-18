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
    home-manager.users.ozzie = {
      stylix.targets.mangohud.enable = false;

      home = {
        packages = with pkgs; [
          lutris
        ];

        sessionVariables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
        };
      };

      programs = {
        mangohud = {
          enable = true;
          enableSessionWide = true;
          package = with pkgs; mangohud;

          settings = {
            preset = 1;
          };
        };
      };
    };

    programs = {
      gamemode.enable = true;

      steam = {
        enable = true;
        gamescopeSession.enable = true;
        package = with pkgs; steam;

        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };
  };
}
