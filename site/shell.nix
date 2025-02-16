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
      bat
      doggo
      duf
      dust
      eza
      fastfetch
      ripgrep
    ];
  };

  programs = {
    bash.shellAliases = aliases;
    zsh.shellAliases = aliases;
  };
}
