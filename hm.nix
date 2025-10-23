{
  config,
  lib,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    sharedModules = [
      {
        ozzie.workstation.preset = lib.mkDefault config.ozzie.workstation.preset;
      }
    ];
  };
}
