{
  console.keyMap = "us";
  time.timeZone = "Australia/Sydney";

  i18n = {
    defaultLocale = "en_AU.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };

  nix.settings = {
    trusted-users = [ "root" ];

    experimental-features = [
      "flakes"
      "nix-command"
    ];
  };

  programs = {
    vim.defaultEditor = true;

    nh = {
      enable = true;
      flake = "/data/nixos/flake";
    };
  };

  services = {
    netbird.enable = true;
    openssh.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
