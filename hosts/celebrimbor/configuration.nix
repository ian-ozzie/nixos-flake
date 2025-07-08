{
  boot = {
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
        "[workspace 1] $terminal"
        "[workspace 8 silent] $browser"
      ];

      monitor = [
        "DP-1,3440x1440@144,0x0,1"
        "DP-2,1920x1200@60,680x-1440,1"
      ];
    };
  };

  networking = {
    dhcpcd.enable = true;
    hostId = "b39dce7f";

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
  };

  site = {
    hardware = {
      intel-b580.enable = true;
      intel-i5-13600k.enable = true;

      wooting-80he.enable = true;
      xbox-wireless-adapter.enable = true;
    };

    ozzie = {
      games = true;
      work = true;
    };

    roles = {
      desktop.enable = true;
    };
  };
}
