{
  pkgs,
  ...
}:
{
  boot = {
    kernelPackages = with pkgs; linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
      };
    };
  };

  home-manager.users.ozzie = {
    ozzie = {
      workstation = {
        hyprsunset.enable = false;
      };
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "[workspace 1] kitty"
        "[workspace 2 silent] brave"
        "[workspace 3 silent] google-chrome-stable"
        "[workspace 3 silent] slack"
        "[workspace 8 silent] firefox"
        "[workspace 8 silent] kitty"
        "[workspace 9 silent] obsidian"
        "[workspace 10 silent] feishin"
      ];

      monitor = [
        "DP-11,1920x1200@60,-1200x-240,1,transform,3"
        "DP-9,2560x1440@99.95,0x0,1"
        "DP-1,1920x1200@60,2560x-240,1,transform,1"
      ];

      workspace = [
        "1,monitor:DP-9"
        "2,monitor:DP-9"
        "3,monitor:DP-9"
        "4,monitor:DP-9"
        "5,monitor:DP-9"
        "6,monitor:DP-9"
        "7,monitor:DP-9"
        "8,monitor:DP-9"
        "9,monitor:DP-11"
        "10,monitor:DP-1"
      ];
    };
  };

  networking = {
    dhcpcd.enable = true;

    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  ozzie = {
    lab = {
      acme.enable = true;
      adguardhome.enable = true;
      syncthing.enable = true;
      traefik.enable = true;
    };

    workstation = {
      printing.enable = true;

      nvf.languages = {
        nix.enable = true;
        php.enable = true;
        rust.enable = true;
      };

      theme.wallpaper = {
        height = 1440;
        svg = ./square.svg;
        width = 2560;
      };
    };
  };

  site = {
    environment.work.enable = true;

    hardware = {
      framework-desktop-amd-ai-max-300-series.enable = true;

      fujifilm-apeos-c4570.enable = true;
      keychron-q3.enable = true;
    };

    ozzie = {
      games = false;
      work = true;
    };

    roles = {
      desktop.enable = true;
    };
  };

  systemd.network = {
    enable = true;

    networks."10-lan" = {
      dhcpV4Config.UseDNS = false;
      name = "enp191s0";
      networkConfig.DHCP = "ipv4";
    };

    wait-online = {
      ignoredInterfaces = [ "wt0" ];
      timeout = 10;
    };
  };
}
