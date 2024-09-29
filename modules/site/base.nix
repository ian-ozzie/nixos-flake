_: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root"];
  };

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

  services = {
    openssh.enable = true;
    netbird.enable = true;

    xserver = {
      xkb = {
        variant = "";
        layout = "us";
      };
    };
  };

  console.keyMap = "us";

  programs = {
    vim.defaultEditor = true;

    nh = {
      enable = true;
      flake = "/data/nixos/flake";
    };
  };
}
