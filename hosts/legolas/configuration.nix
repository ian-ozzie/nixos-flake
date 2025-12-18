{
  boot = {
    kernelParams = [ "video=eDP-1:2880x1920@120" ];
    plymouth.extraConfig = "DeviceScale=1";

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
      bind = [
        ", switch:on:Lid Switch, exec, hyprctl dispatch dpms off & hyprlock --immediate"
        ", switch:off:Lid Switch, exec, hyprctl dispatch dpms on"
      ];

      exec-once = [
        "brightnessctl set 10"
        "brightnessctl -d framework_laptop::kbd_backlight set 100"
        "brightnessctl -d chromeos:white:power set 0"
        "[workspace 1] kitty"
        "[workspace 8 silent] firefox"
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

    workstation = {
      nvf.languages = {
        nix.enable = true;
        php.enable = true;
        rust.enable = true;
      };

      theme.wallpaper = {
        height = 1920;
        svg = ./square.svg;
        width = 2880;
      };
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
