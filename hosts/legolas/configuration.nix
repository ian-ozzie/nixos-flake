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
      monitor = [
        ",preferred,auto,auto"
      ];
    };
  };

  networking = {
    dhcpcd.enable = true;
    hostId = "bc7acc81";

    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  ozzie = {
    lab = {
      acme.enable = true;
      adguardhome.enable = true;
      traefik.enable = true;
    };
  };

  site = {
    hardware = {
      framework-13-7040-amd.enable = true;
    };

    ozzie = {
      games = true;
      work = true;
    };

    roles = {
      laptop.enable = true;
    };
  };
}
