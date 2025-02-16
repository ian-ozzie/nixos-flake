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
          brave
          firefox

          discord
          obsidian

          openscad-unstable
          qidi-slicer-bin

          gimp
          inkscape

          losslesscut-bin
          vlc

          supersonic
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
    };
  };
}
