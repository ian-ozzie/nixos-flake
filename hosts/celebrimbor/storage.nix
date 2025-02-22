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
              size = "32G";

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
                  pool = "rpool";
                  type = "zfs";
                };
              };
            };
          };
        };
      };
    };

    zpool = {
      rpool = {
        datasets = {
          "local" = {
            options.mountpoint = "none";
            type = "zfs_fs";
          };

          "local/root" = {
            mountpoint = "/";
            postCreateHook = "zfs snapshot rpool/local/root@blank";
            type = "zfs_fs";

            options = {
              canmount = "noauto";
              mountpoint = "legacy";
            };
          };

          "local/nix" = {
            mountpoint = "/nix";
            type = "zfs_fs";

            options = {
              atime = "off";
              canmount = "noauto";
              mountpoint = "legacy";
            };
          };

          "safe" = {
            options.mountpoint = "none";
            type = "zfs_fs";
          };

          "safe/data" = {
            mountpoint = "/data";
            type = "zfs_fs";

            options = {
              canmount = "noauto";
              mountpoint = "legacy";
            };
          };

          "safe/home" = {
            mountpoint = "/home";
            type = "zfs_fs";

            options = {
              canmount = "noauto";
              mountpoint = "legacy";
            };
          };

          "backup" = {
            mountpoint = "/backup";
            options."com.sun:auto-snapshot" = "false";
            type = "zfs_fs";
          };
        };

        options = {
          ashift = "12";
          autotrim = "on";
        };

        rootFsOptions = {
          acltype = "posixacl";
          canmount = "off";
          compression = "zstd";
          dnodesize = "auto";
          mountpoint = "none";
          normalization = "formD";
          relatime = "on";
          xattr = "sa";
        };
      };
    };
  };
}
