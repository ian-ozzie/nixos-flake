{
  lib,
  ...
}:
{
  console.keyMap = "us";
  time.timeZone = "Australia/Sydney";

  boot.loader = {
    grub.configurationLimit = 10;
    systemd-boot.configurationLimit = 10;
  };

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

  nix = {
    gc = {
      automatic = true;
      dates = "03:45";
    };

    optimise = {
      automatic = true;
      dates = [ "02:45" ];
    };

    settings = {
      auto-optimise-store = true;
      keep-going = true;

      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  ozzie = {
    workstation = {
      nvf.enable = true;
    };
  };

  programs = {
    nh = {
      enable = true;
      flake = "/data/nixos/flake";
    };
  };

  services = {
    netbird.enable = true;

    openssh = {
      enable = true;

      settings = {
        AllowUsers = [ ];
        PasswordAuthentication = false;
        PermitRootLogin = lib.mkDefault "no";
      };
    };

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
