{
  description = "Ozzie's NixOS flake";

  inputs = {
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    ozzie-lab = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+ssh://git/ozzie/nixos-lab.git";
    };

    ozzie-workstation = {
      url = "git+ssh://git/ozzie/nix-workstation.git";

      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        stylix.follows = "stylix";
      };
    };

    ozzie-secrets = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+ssh://git/ozzie/nixos-secrets.git";
    };

    stylix = {
      url = "github:nix-community/stylix";

      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    inputs@{
      ozzie-lab,
      ozzie-workstation,
      self,
      stylix,
      ...
    }:
    let
      coreHomeModules = [
        ozzie-workstation.homeModules.default
      ];

      coreModules = [
        ozzie-lab.nixosModules.default
        ozzie-workstation.nixosModules.default
        self.nixosModules.site
        stylix.nixosModules.stylix
      ];

      overlays = [
        (_: prev: {
          kitty = prev.kitty.overrideAttrs (oldAttrs: {
            patches = (oldAttrs.patches or [ ]) ++ [
              ./patches/kitty-mouse-resize.patch
            ];
          });

          xc = prev.xc.overrideAttrs (oldAttrs: {
            patches = (oldAttrs.patches or [ ]) ++ [
              ./patches/xc-remove-output-wrapper.patch
            ];
          });
        })
      ];
    in
    {
      nixosConfigurations = ozzie-lab.lib.genNixOSHosts {
        inherit
          coreHomeModules
          coreModules
          inputs
          overlays
          ;

        specialArgs = {
          inherit inputs;
        };
      };

      isoConfigurations = ozzie-lab.lib.genNixOSHosts {
        inherit
          coreHomeModules
          coreModules
          inputs
          overlays
          ;

        directory = "${inputs.self}/isos";
      };

      deprecatedConfigurations = ozzie-lab.lib.genNixOSHosts {
        inherit
          coreHomeModules
          coreModules
          inputs
          overlays
          ;

        directory = "${inputs.self}/deprecated";
      };

      nixosModules = {
        home = import ./hm.nix;
        site = import ./.;
        users = import ./users;
      };
    };
}
