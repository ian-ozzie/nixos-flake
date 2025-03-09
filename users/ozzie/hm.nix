{
  lib,
  pkgs,
  ...
}:
{
  options.site.ozzie = {
    games = lib.mkEnableOption "set up ozzie for games";
    work = lib.mkEnableOption "set up ozzie for work";
  };

  imports = [
    ./games.nix
    ./work.nix
  ];

  config = {
    home-manager.users.ozzie = {
      home = {
        stateVersion = "24.11";

        packages = with pkgs; [
          obsidian

          brave
          browsers
          firefox

          discord
          mpv
          supersonic
          vlc

          openscad-unstable
          qidi-slicer-bin

          gimp
          inkscape
          losslesscut-bin
        ];
      };

      ozzie.workstation = {
        kitty.enable = true;
      };

      programs = {
        bash = {
          enable = true;
          initExtra = ''
            [ -f $HOME/.bashrc.d/init.bashrc ] && source $HOME/.bashrc.d/init.bashrc
          '';
        };

        btop = {
          enable = true;
        };
      };

      xdg = {
        mimeApps = {
          enable = true;
          defaultApplications =
            let
              browser = "software.Browsers.desktop";
            in
            {
              "text/html" = browser;
              "x-scheme-handler/about" = browser;
              "x-scheme-handler/http" = browser;
              "x-scheme-handler/https" = browser;
              "x-scheme-handler/unknown" = browser;
            };
        };
      };
    };
  };
}
