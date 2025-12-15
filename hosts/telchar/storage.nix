{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";

        content = {
          type = "gpt";

          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };

            esp = {
              name = "ESP";
              size = "1023M";
              type = "EF00";

              content = {
                format = "vfat";
                mountpoint = "/boot";
                type = "filesystem";
              };
            };

            swap = {
              name = "swap";
              size = "64G";

              content = {
                randomEncryption = true;
                resumeDevice = false;
                type = "swap";
              };
            };

            luks = {
              size = "100%";

              content = {
                name = "crypt";
                settings.allowDiscards = true;
                type = "luks";

                content = {
                  extraArgs = [ "-f" ];
                  type = "btrfs";

                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/data" = {
                      mountpoint = "/data";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
