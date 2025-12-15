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
  state = "24.11";
  system = "x86_64-linux";

  homeModules = [
    ozzie-workstation.homeModules.hyprland
  ];

  modules = [
    disko.nixosModules.disko
    ./storage.nix

    nixos-hardware.nixosModules.framework-desktop-amd-ai-max-300-series

    ozzie-secrets.nixosModules.site
    ozzie-secrets.nixosModules.hosts.telchar

    ozzie-workstation.nixosModules.hyprland

    self.nixosModules.home
    self.nixosModules.users.ozzie
    self.nixosModules.users.ozzieHome

    ./configuration.nix
  ];
}
