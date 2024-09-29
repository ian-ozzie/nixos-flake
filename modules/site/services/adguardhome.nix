{
  config,
  lib,
  ...
}: let
  cfg = config.site.services.adguardhome;
in
  with lib; {
    options.site.services.adguardhome.enable = mkOption {
      type = with types; bool;
      default = false;
      description = "Whether to set up adguardhome";
    };

    config = mkIf cfg.enable {
      services.adguardhome = {
        enable = true;
        host = "127.0.0.53";
        port = 3053;
        mutableSettings = false;
        openFirewall = false;
        allowDHCP = false;
        settings = {
          schema_version = 28;
          users = [];
          theme = "dark";
          dns = {
            bind_hosts = ["127.0.0.53"];
            ports = "53";
            bootstrap_dns = [
              "9.9.9.9"
              "1.1.1.1"
            ];
            upstream_dns = ["https://9.9.9.9/dns-query"];
            fallback_dns = ["https://1.1.1.1/dns-query"];
          };
          filtering = {
            filtering_enabled = true;
            filters_update_interval = 168;
          };
          filters = [
            {
              name = "OISD - Small";
              url = "https://small.oisd.nl/";
              enabled = false;
            }
            {
              name = "OISD - Big";
              url = "https://big.oisd.nl/";
              enabled = true;
            }
            {
              name = "OISD - NSFW";
              url = "https://nsfw.oisd.nl/";
              enabled = true;
            }
          ];
          user_rules = [
            "@@||analytics.google.com^" # Needed for work
          ];
        };
      };

      services.traefik.dynamicConfigOptions.http = {
        routers.dns-web = {
          rule = "Host(`dns.${config.profile.bind.domain}`)";
          entryPoints = "websecure";
          service = "dns-web@file";
          priority = "10";
        };

        services.dns-web = {
          loadBalancer.servers = [{url = "http://127.0.0.53:3053";}];
        };
      };
    };
  }
