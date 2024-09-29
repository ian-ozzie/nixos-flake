{
  nixos-hardware,
  ozzie-secrets,
  ozzie-workstation,
  self,
  ...
}:
{
  system = "x86_64-linux";

  modules = [
    nixos-hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix

    ozzie-secrets.nixosModules.site
    ozzie-secrets.nixosModules.hosts.legolas

    ozzie-workstation.nixosModules.gnome
    self.nixosModules.users.ozzie

    ./configuration.nix
  ];
}
