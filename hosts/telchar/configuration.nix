{
  pkgs,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_13;
    loader = {
      systemd-boot = {
        enable = true;
      };

      efi.canTouchEfiVariables = true;
    };
  };

  programs.ssh.startAgent = true;

  networking = {
    hostId = "5eec05b7";
    hostName = "telchar";
    dhcpcd.enable = true;

    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  home-manager.users.ozzie = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "eDP-1,2560x1440@60,0x0,1"
        "DP-2,1920x1200@60,-1200x-240,1,transform,3"
        "DP-3,1920x1200@60,2560x-240,1,transform,1"
      ];

      exec-once = [
        "[workspace 1] $terminal"
        "[workspace 10 silent] $browser"
      ];
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
}
