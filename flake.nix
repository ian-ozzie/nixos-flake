{
  description = "Ozzie's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    ozzie-lab = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+ssh://git/ozzie/nixos-lab.git";
    };

    ozzie-workstation = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+ssh://git/ozzie/nix-workstation.git";
    };

    ozzie-secrets = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+ssh://git/ozzie/nixos-secrets.git";
    };
  };

  outputs = _: {
    nixosModules = {
      site = import ./.;
    };
  };
}
