{
  lib,
  ...
}: {
  options = {
    profile = {
      bind.ip = lib.mkOption {
        type = lib.types.str;
        default = "127.0.0.1";
        description = "IP to bind services to";
      };

      bind.domain = lib.mkOption {
        type = lib.types.str;
        default = "localhost";
        description = "Hostname to bind services to";
      };

      type = lib.mkOption {
        type = lib.types.str;
        default = "laptop";
        description = "Type of system that influences base configuration";
      };
    };
  };
}
