{
  description = "Ozzie's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    secrets.url = "git+file:///data/nixos/secrets";
    #secrets.url = "git+ssh://git/ozzie/nixos-secrets.git";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    lib = import ./lib;

    nixosConfigurations = self.lib.genNixOSHosts {
      inherit self inputs;

      baseModules = [
        self.nixosModules.default
      ];
    };

    nixosModules.default = import ./modules;

    isoConfigurations = {
      installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (
            {
              modulesPath,
              ...
            }: {
              imports = [
                (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")

                images/installer-minimal.nix
              ];
            }
          )
        ];
      };
    };
  };
}
