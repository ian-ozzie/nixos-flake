{
  description = "Ozzie's NixOS flake";

  inputs = {
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };

    nvf = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:notashelf/nvf";
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
        nvf.follows = "nvf";
        stylix.follows = "stylix";
      };
    };

    ozzie-secrets = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+ssh://git/ozzie/nixos-secrets.git";
    };

    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/stylix/release-25.11";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nvf,
      ozzie-lab,
      ozzie-workstation,
      self,
      stylix,
      ...
    }:
    let
      coreHomeModules = [
        nvf.homeManagerModules.default
        ozzie-workstation.homeModules.default
      ];

      coreModules = [
        nvf.nixosModules.default
        ozzie-lab.nixosModules.default
        ozzie-workstation.nixosModules.default
        self.nixosModules.site
        stylix.nixosModules.stylix
      ];

      overlays = [
        (_: prev: {
          gita = prev.gita.overrideAttrs (_: rec {
            version = "0.16.8.2";

            src = prev.fetchFromGitHub {
              owner = "nosarthur";
              repo = "gita";
              rev = "v${version}";
              sha256 = "sha256-JzfGj17YCYXmpGV2jSsGLsG1oqO5ynj7r3u/mkSBRBg=";
            };
          });

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

      systems = [ "x86_64-linux" ];
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (
        system:
        let
          inherit (nixpkgs.legacyPackages.${system}) mkShell;

          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          default = mkShell {
            packages = with pkgs; [
              nixd
            ];
          };
        }
      );

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
