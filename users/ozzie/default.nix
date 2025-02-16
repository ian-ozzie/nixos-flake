{
  pkgs,
  ...
}:
{
  nix.settings.trusted-users = [ "ozzie" ];
  services.openssh.settings.AllowUsers = [ "ozzie" ];

  users.users.ozzie = {
    extraGroups = [ "wheel" ];
    initialPassword = "fresh-SYSTEM-password-1789";
    isNormalUser = true;
    shell = with pkgs; bash;
    uid = 1789;

    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHAvNhEwvqPZ+k5M3lCUXtw2Qpz8+fSaam1JoWwWDd/MAAAABHNzaDo="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAa4s0F5Y84QIl4awca5O54sNZXPOaXRFhiuYLfUJ1f3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOedK/iBJQbrnt28ar65nxcCDc94DFStXVLU6Ph7GNI"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHj2clFHRheJ4zDWUwWXaow9OFAHtHBaDjdFpXVwuXDR"
    ];

    packages = with pkgs; [
      atuin

      alejandra
      deadnix
      nix-search
      statix

      socat
      unzip
    ];
  };
}
