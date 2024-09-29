{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    vim
    xc
    nixfmt-rfc-style
    bind.dnsutils
    wget
    curl
    lsof
    strace
    htop
    rsync
    man
    screen
    inetutils
  ];
}
