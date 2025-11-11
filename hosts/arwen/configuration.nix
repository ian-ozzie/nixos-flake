{
  config,
  ...
}:
{
  boot = {
    loader = {
      grub = {
        efiInstallAsRemovable = true;
        efiSupport = true;
        enable = true;

        mirroredBoots = [
          {
            devices = [ "nodev" ];
            path = "/boot";
            efiSysMountPoint = "/boot";
          }
          {
            devices = [ "nodev" ];
            path = "/boot-mirror";
            efiSysMountPoint = "/boot-mirror";
          }
        ];
      };
    };
  };

  networking = {
    hostId = "4e9c1f82";

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
  };

  ozzie = {
    lab = {
      acme.enable = true;
      forgejo.enable = true;
      gitea-actions-runner.enable = true;
      mysql.enable = true;
      mysql.backup.enable = true;
      ncps.enable = true;
      syncthing.enable = true;
      traefik.enable = true;
      vaultwarden.enable = true;

      adguardhome = {
        allowed = [ ];
        bind = [ config.ozzie.lab.host.bind.ip ];
        enable = true;
      };
    };
  };

  site = {
    environment.lab.enable = true;

    hardware = {
      intel-n150.enable = true;
    };

    roles = {
      server.enable = true;
    };
  };
}
