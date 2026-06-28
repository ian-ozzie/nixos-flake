{
  description = "Ozzie's NixOS flake";

  inputs = {
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };

    git-hooks = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cachix/git-hooks.nix";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-26.05";
    };

    nvf = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:notashelf/nvf";
    };

    ozzie-lab = {
      url = "git+ssh://git/ozzie/nixos-lab.git";

      inputs = {
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
      };
    };

    ozzie-workstation = {
      url = "git+ssh://git/ozzie/nix-workstation.git";

      inputs = {
        git-hooks.follows = "git-hooks";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        nvf.follows = "nvf";
        stylix.follows = "stylix";
      };
    };

    ozzie-secrets = {
      url = "git+ssh://git/ozzie/nixos-secrets.git";

      inputs = {
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
      };
    };

    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/stylix/release-26.05";
    };
  };

  outputs =
    inputs@{
      git-hooks,
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

          openterface-qt = prev.openterface-qt.overrideAttrs (_: rec {
            version = "0.5.20";

            src = prev.fetchFromGitHub {
              hash = "sha256-yD71UOi6iRd9N3NeASUzqoeHMcTYIqkysAfxRm7GkOA=";
              owner = "TechxArtisanStudio";
              repo = "Openterface_QT";
              rev = version;
            };
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

          gitHooks = git-hooks.lib.${system}.run {
            src = ./.;

            hooks = {
              deadnix.enable = true;
              nixfmt.enable = true;

              check-flake = {
                enable = true;
                entry = "nix flake check";
                pass_filenames = false;
                types = [ "nix" ];
              };
            };
          };
        in
        {
          default = mkShell {
            inherit (gitHooks) shellHook;

            buildInputs = gitHooks.enabledPackages;

            packages = with pkgs; [
              nixd
              xc
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
