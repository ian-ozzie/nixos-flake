{
  self,
  ...
}:
{
  system = "x86_64-linux";

  modules = [
    self.nixosModules.users.ozzie

    (
      { modulesPath, ... }:
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
          settings.AllowUsers = [ "root" ];
        };
      }
    )
  ];
}
