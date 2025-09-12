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
    services.hypridle.settings.listener = [
      {
        on-resume = "brightnessctl -d framework_laptop::kbd_backlight set 100";
        on-timeout = "brightnessctl -d framework_laptop::kbd_backlight set 0";
        timeout = 60;
      }
      {
        on-resume = "brightnessctl -d chromeos:white:power set 0";
        on-timeout = "brightnessctl -d chromeos:white:power set 1";
        timeout = 360;
      }
    ];

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "brightnessctl set 10"
        "brightnessctl -d framework_laptop::kbd_backlight set 100"
        "brightnessctl -d chromeos:white:power set 0"
        "[workspace 1] $terminal"
        "[workspace 8 silent] $browser"
      ];

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
      syncthing.enable = true;
      traefik.enable = true;
    };
  };

  site = {
    environment.lab.enable = true;

    hardware = {
      framework-13-7040-amd.enable = true;

      openterface-mini-kvm.enable = true;
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
