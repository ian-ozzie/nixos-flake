{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.users.users.ozzie) home;
in
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
        homeDirectory = home;
        stateVersion = "24.11";

        packages = with pkgs; [
          pcmanfm
          viewnior
          wl-clipboard

          bitwarden
          obsidian

          brave
          browsers
          firefox

          calibre
          discord
          lrcget
          mpv
          strawberry
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

      wayland.windowManager.hyprland.settings.exec-once = [
        "netbird-ui"
      ];

      xdg = {
        mimeApps = {
          enable = true;
          defaultApplications =
            let
              browser = "software.Browsers.desktop";
              explorer = "pcmanfm.desktop";
              images = "viewnior.desktop";
              terminal = "kitty.desktop";
              videos = "mpv.desktop";
            in
            {
              "text/html" = browser;
              "x-scheme-handler/about" = browser;
              "x-scheme-handler/http" = browser;
              "x-scheme-handler/https" = browser;
              "x-scheme-handler/unknown" = browser;

              "inode/directory" = explorer;

              "image/bmp" = images;
              "image/gif" = images;
              "image/jpeg" = images;
              "image/jpg" = images;
              "image/png" = images;
              "image/tiff" = images;
              "image/webp" = images;

              "terminal" = terminal;
              "x-scheme-handler/terminal" = terminal;

              "video/mp2t" = videos;
              "video/mp4" = videos;
              "video/mpeg" = videos;
              "video/ogg" = videos;
              "video/webm" = videos;
              "video/x-flv" = videos;
              "video/x-matroska" = videos;
              "video/x-msvideo" = videos;
            };
        };

        userDirs = {
          enable = true;
          createDirectories = true;

          desktop = "${home}/files/desktop";
          documents = "${home}/files/documents";
          download = "${home}/downloads";
          music = "${home}/files/music";
          pictures = "${home}/pictures";
          publicShare = "${home}/files/public";
          templates = "${home}/files/templates";
          videos = "${home}/files/videos";
        };
      };
    };
  };
}
