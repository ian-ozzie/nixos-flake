{
  description = "Ozzie's NixOS flake";

  inputs = {
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

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

  outputs =
    inputs@{
      ozzie-lab,
      self,
      ...
    }:
    let
      coreModules = [
        ozzie-lab.nixosModules.default
        self.nixosModules.site
      ];
    in
    {
      nixosConfigurations = ozzie-lab.lib.genNixOSHosts {
        inherit
          coreModules
          inputs
          ;

        specialArgs = {
          inherit inputs;
        };
      };

      isoConfigurations = ozzie-lab.lib.genNixOSHosts {
        inherit
          coreModules
          inputs
          ;

        directory = "${inputs.self}/isos";
      };

      nixosModules = {
        site = import ./.;
        users = import ./users;
      };
    };
}
