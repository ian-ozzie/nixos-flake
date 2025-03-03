{
  pkgs,
  ...
}:
let
  flavors-repo = pkgs.fetchFromGitHub {
    hash = "sha256-h12BKKmHFfuMOpGx6F7obgofw/NnWBSeKsWY6tIxUUA=";
    owner = "yazi-rs";
    repo = "flavors";
    rev = "1a419b2e20436155da464e1cd6cd127723938f78";
  };

  plugins-repo = pkgs.fetchFromGitHub {
    hash = "sha256-enIt79UvQnKJalBtzSEdUkjNHjNJuKUWC4L6QFb3Ou4=";
    owner = "yazi-rs";
    repo = "plugins";
    rev = "beb586aed0d41e6fdec5bba7816337fdad905a33";
  };
in
{
  programs.yazi = {
    enable = true;

    flavors = {
      mocha = "${flavors-repo}/catppuccin-mocha.yazi";
    };

    plugins = {
      chmod = "${plugins-repo}/chmod.yazi";

      starship = pkgs.fetchFromGitHub {
        owner = "Rolv-Apneseth";
        repo = "starship.yazi";
        rev = "f6939fbdbc3fdfcdc2a80251841e429e0cd5cf3c";
        sha256 = "sha256-5QQsFozbulgLY/Gl6QuKSOTtygULveoRD49V00e0WOw=";
      };
    };

    settings = {
      keymap = builtins.fromTOML (builtins.readFile ./keymap.toml);
      theme = builtins.fromTOML (builtins.readFile ./theme.toml);
      yazi = builtins.fromTOML (builtins.readFile ./yazi.toml);
    };
  };
}
