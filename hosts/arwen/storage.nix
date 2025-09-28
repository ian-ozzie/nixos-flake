{
  disko.devices = {
    disk = {
      nvme0 = {
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
                mountOptions = [ "nofail" ];
                mountpoint = "/boot";
                type = "filesystem";
              };
            };

            swap = {
              name = "swap0";
              size = "32G";

              content = {
                randomEncryption = true;
                resumeDevice = false;
                type = "swap";
              };
            };

            rpool = {
              size = "100%";

              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };

      nvme1 = {
        device = "/dev/nvme1n1";
        type = "disk";

        content = {
          type = "gpt";

          partitions = {
            boot = {
              name = "boot-mirror";
              size = "1M";
              type = "EF02";
            };

            esp = {
              name = "ESP-mirror";
              size = "1023M";
              type = "EF00";

              content = {
                format = "vfat";
                mountOptions = [ "nofail" ];
                mountpoint = "/boot-mirror";
                type = "filesystem";
              };
            };

            swap = {
              name = "swap1";
              size = "32G";

              content = {
                randomEncryption = true;
                resumeDevice = false;
                type = "swap";
              };
            };

            rpool = {
              size = "100%";

              content = {
                pool = "rpool";
                type = "zfs";
              };
            };
          };
        };
      };

      sda = {
        device = "/dev/sda";
        type = "disk";

        content = {
          type = "gpt";

          partitions = {
            tank = {
              size = "100%";

              content = {
                pool = "tank";
                type = "zfs";
              };
            };
          };
        };
      };

      sdb = {
        device = "/dev/sdb";
        type = "disk";

        content = {
          type = "gpt";

          partitions = {
            tank = {
              size = "100%";

              content = {
                pool = "tank";
                type = "zfs";
              };
            };
          };
        };
      };
    };

    zpool = {
      rpool = {
        mode = "mirror";

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

      tank = {
        mode = "mirror";

        datasets = {
          "cache" = {
            mountpoint = "/cache";
            type = "zfs_fs";

            options = {
              mountpoint = "legacy";
              canmount = "noauto";
            };
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
