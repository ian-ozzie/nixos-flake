{
  config,
  lib,
  ...
}: let
  cfg = config.site.services.traefik;
in
  with lib; {
    options.site.services.traefik.enable = mkOption {
      type = with types; bool;
      default = false;
      description = "Whether to set up traefik";
    };

    config = mkIf cfg.enable {
      services.traefik = {
        enable = true;
        staticConfigOptions = {
          global = {
            checkNewVersion = false;
            sendAnonymousUsage = false;
          };

          log = {
            level = "INFO";
            filePath = "/var/log/traefik.log";
          };

          accessLog = {
            filePath = "/var/log/traefik-access.log";
          };

          providers.docker = {
            exposedByDefault = false;
            watch = true;
          };

          api.dashboard = true;
          global = {
            checknewversion = false;
            sendanonymoususage = false;
          };

          serversTransport.insecureSkipVerify = "true";

          entryPoints = {
            web = {
              address = "127.0.0.1:80";
            };

            websecure = {
              address = "${config.profile.bind.ip}:443";
              http.tls = true;
            };
          };
        };

        dynamicConfigOptions.http = {
          routers = {
            traefik = {
              rule = "Host(`traefik.${config.profile.bind.domain}`)";
              entryPoints = "websecure";
              service = "api@internal";
              priority = "10";
            };
          };
        };
      };

      systemd.services.traefik.serviceConfig.WorkingDirectory = "${config.services.traefik.package}/bin";
    };
  }
