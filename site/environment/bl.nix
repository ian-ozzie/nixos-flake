{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.lab.users) nix-deploy;

  cfg = config.site.environment.bl;
in
{
  options.site.environment.bl = {
    enable = lib.mkEnableOption "shared bl configuration";
  };

  config = lib.mkIf cfg.enable {
    ozzie.lab.users.nix-deploy.enable = lib.mkDefault true;

    users.users.nix-deploy = lib.mkIf nix-deploy.enable {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO+G4/MK+RrKlRKvRPOko1LIdxQ8fE6dXeEn/22pp52"
      ];
    };
  };
}
