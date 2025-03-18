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
    ls = "eza --group --group-directories-first -l --icons";
    tree = "eza --tree --group-directories-first --icons";
  };
in
{
  environment = {
    systemPackages = with pkgs; [
      bandwhich
      bat
      btop
      curl
      doggo
      duf
      dust
      eza
      fastfetch
      git
      iftop
      inetutils
      iotop
      jq
      lshw
      lsof
      man
      mtr
      pre-commit
      ripgrep
      rsync
      scc
      screen
      strace
      tcpdump
      tealdeer
      trippy
      vim
      wget
      xc
      xh
    ];
  };

  programs = {
    bash.shellAliases = aliases;
    zsh.shellAliases = aliases;
  };
}
