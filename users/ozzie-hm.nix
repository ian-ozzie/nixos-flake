{
  pkgs,
  ...
}:
{
  home-manager.users.ozzie = {
    home = {
      stateVersion = "24.11";

      packages = with pkgs; [
        firefox
        kitty

        discord

        openscad-unstable
        qidi-slicer-bin

        gimp
        inkscape

        losslesscut-bin
        vlc

        supersonic
      ];
    };

    programs = {
      bash = {
        enable = true;
        initExtra = ''
          [ -f $HOME/.bashrc.d/init.bashrc ] && source $HOME/.bashrc.d/init.bashrc
        '';
      };

      starship = {
        enable = true;
        enableBashIntegration = false; # Integration handled by my .bashrc.d
      };
    };
  };
}
