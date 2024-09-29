{
  config,
  pkgs,
  ...
}: {
  nix.settings.trusted-users = ["ozzie"];

  users.groups.ozzie.gid = 1789;
  users.users.ozzie = {
    initialPassword = "fresh-SYSTEM-password-1789";
    uid = 1789;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEo73AUdtUjC7S27xJX5pGeDunWbqrOzIa2kCTt72R2B"
    ];
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tre
    ];
  };

  programs = {
    zsh.enable = true;

    starship.enable = true;
  };
}
