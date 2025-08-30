{
  nixos-hardware,
  ozzie-secrets,
  self,
  ...
}:
{
  allowUnfree = true;
  home = false;
  state = "23.11";
  system = "x86_64-linux";

  modules = [
    nixos-hardware.nixosModules.common-cpu-amd
    ./hardware-configuration.nix

    ozzie-secrets.nixosModules.site
    ozzie-secrets.nixosModules.hosts.galadriel

    self.nixosModules.users.ozzie

    ./configuration.nix
  ];
}
