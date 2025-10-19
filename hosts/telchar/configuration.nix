{
  boot = {
    kernelParams = [ "libata.force=1.00:disable" ]; # Disable dead spinning disk that was part of the fusion drive

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
      };
    };
  };

  home-manager.users.ozzie = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "[workspace 1] kitty"
        "[workspace 2 silent] google-chrome-stable"
        "[workspace 3 silent] slack"
        "[workspace 8 silent] firefox"
        "[workspace 9 silent] obsidian"
        "[workspace 10 silent] supersonic"
      ];

      monitor = [
        "eDP-1,2560x1440@60,0x0,1"
        "DP-2,1920x1200@60,-1200x-240,1,transform,3"
        "DP-3,1920x1200@60,2560x-240,1,transform,1"
      ];

      workspace = [
        "1,monitor:eDP-1"
        "2,monitor:eDP-1"
        "3,monitor:eDP-1"
        "4,monitor:eDP-1"
        "5,monitor:eDP-1"
        "6,monitor:eDP-1"
        "7,monitor:eDP-1"
        "8,monitor:eDP-1"
        "9,monitor:DP-2"
        "10,monitor:DP-3"
      ];
    };
  };

  networking = {
    dhcpcd.enable = true;
    hostId = "5eec05b7";

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
      theme.wallpaper = {
        height = 1440;
        width = 2560;
      };
    };
  };

  site = {
    environment.work.enable = true;

    hardware = {
      apple-imac-19-1.enable = true;

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
      name = "enp4s0f0";
      networkConfig.DHCP = "ipv4";
    };
  };
}
