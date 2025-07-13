{
  disko,
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
    disko.nixosModules.disko
    ./storage.nix

    nixos-hardware.nixosModules.framework-13-7040-amd

    ozzie-secrets.nixosModules.site
    ozzie-secrets.nixosModules.hosts.legolas

    ozzie-workstation.nixosModules.hyprland

    self.nixosModules.home
    self.nixosModules.users.ozzie
    self.nixosModules.users.ozzieHome

    ./configuration.nix
  ];
}
