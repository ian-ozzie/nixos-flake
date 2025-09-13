{
  disko,
  nixos-hardware,
  ozzie-secrets,
  self,
  ...
}:
{
  allowUnfree = true;
  home = false;
  state = "25.11";
  system = "x86_64-linux";

  modules = [
    disko.nixosModules.disko
    ./storage.nix

    nixos-hardware.nixosModules.common-cpu-intel

    ozzie-secrets.nixosModules.site
    ozzie-secrets.nixosModules.hosts.arwen

    self.nixosModules.users.ozzie

    ./configuration.nix
  ];
}
