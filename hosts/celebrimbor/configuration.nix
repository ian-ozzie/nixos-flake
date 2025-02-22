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
      traefik.enable = true;
    };
  };

  site = {
    ozzie = {
      games = true;
      work = true;
    };

    roles = {
      desktop.enable = true;
    };
  };
}
