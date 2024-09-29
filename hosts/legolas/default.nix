{
  nixos-hardware,
  secrets,
  ...
}: {
  system = "x86_64-linux";

  modules = [
    nixos-hardware.nixosModules.framework-13-7040-amd
    secrets.nixosModules.site
    secrets.nixosModules.legolas
    ./configuration.nix
  ];

  profile = {
    bind.ip = "127.0.0.1";
  };

  roles = {
    laptop = true;
  };

  site = {
    hardware.framework-13-7040-amd.enable = true;
    services = {
      traefik.enable = true;
      adguardhome.enable = true;
    };
  };
}
