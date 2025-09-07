{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
      };
    };
  };

  networking = {
    dhcpcd.enable = false;
    hostId = "7ae37dbe";
    hostName = "galadriel";

    bridges = {
      br1000 = {
        interfaces = [ "vlan1000" ];
      };
    };

    firewall = {
      allowedTCPPorts = [
        22
        53
        80
        443
      ];

      allowedUDPPorts = [
        53
        443
      ];
    };

    vlans = {
      vlan1000 = {
        id = 1000;
        interface = "enp4s0";
      };
    };
  };

  ozzie = {
    lab = {
      acme.enable = true;
      adguardhome.enable = true;
      forgejo.enable = true;
      gitea-actions-runner.enable = true;
      mysql.enable = true;
      mysql.backup.enable = true;
      ncps.enable = true;
      syncthing.enable = true;
      traefik.enable = true;
      unifi.enable = true;
      vaultwarden.enable = true;
    };
  };

  site = {
    hardware = {
      amd-ryzen-7-4750g.enable = true;
    };

    roles = {
      server.enable = true;
    };
  };
}
