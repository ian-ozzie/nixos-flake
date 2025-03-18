{
  self,
  ...
}:
{
  system = "x86_64-linux";

  modules = [
    self.nixosModules.users.ozzie

    (
      {
        config,
        lib,
        modulesPath,
        ...
      }:
      {
        imports = [
          (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
        ];

        isoImage = {
          makeEfiBootable = true;
          makeUsbBootable = true;
        };

        services.openssh = {
          enable = true;

          settings = {
            AllowUsers = [ "root" ];
            PermitRootLogin = lib.mkForce "without-password";
          };
        };

        users.users.root.openssh.authorizedKeys = {
          inherit (config.users.users.ozzie.openssh.authorizedKeys) keys;
        };
      }
    )
  ];
}
