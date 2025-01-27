{
  nixos-hardware,
  ozzie-secrets,
  ozzie-workstation,
  self,
  ...
}:
{
  allowUnfree = true;
  home = true;
  state = "24.05";
  system = "x86_64-linux";

  homeModules = [
    ozzie-workstation.homeModules.hyprland
  ];

  modules = [
    nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix

    ozzie-secrets.nixosModules.site
    ozzie-secrets.nixosModules.hosts.legolas

    ozzie-workstation.nixosModules.hyprland

    self.nixosModules.home
    self.nixosModules.users.ozzie
    self.nixosModules.users.ozzieHome

    ./configuration.nix
  ];
}
