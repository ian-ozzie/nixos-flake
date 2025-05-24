{
  pkgs,
  ...
}:
let
  aliases = {
    bat = "bat --theme base16";
    cat = "bat --paging never --style plain";
    df = "duf -only local";
    dig = "doggo";
    du = "dust";
    grep = "rg --no-heading -N";
    less = "bat --paging always --style plain";
    ls = "lsd";
    tree = "lsd --tree";
  };
in
{
  environment = {
    enableAllTerminfo = true;

    systemPackages = with pkgs; [
      bat
      csview
      curl
      doggo
      duf
      dust
      fastfetch
      fd
      git
      inetutils
      jq
      lsd
      lshw
      lsof
      man
      ripgrep
      rsync
      scc
      screen
      strace
      tcpdump
      tealdeer
      wget
      xc
      xh

      bandwhich
      btop
      iftop
      iotop
      mtr
      trippy

      nixfmt-rfc-style
      pre-commit
    ];
  };

  programs = {
    bash.shellAliases = aliases;
    zsh.shellAliases = aliases;
  };
}
