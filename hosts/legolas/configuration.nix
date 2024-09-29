{
  system.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;

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
    hostId = "bc7acc81";
    hostName = "legolas";

    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  ozzie = {
    lab = {
      adguardhome.enable = true;
      traefik.enable = true;
    };
  };

  site = {
    hardware = {
      framework-13-7040-amd.enable = true;
    };

    roles = {
      laptop.enable = true;
    };
  };
}
