{...}: {
  disk.nvme0n1 = {
    device = "/dev/nvme0n1";
    type = "disk";
    content = {
      type = "table";
      format = "gpt";
      partitions = [
        {
          name = "ESP";
          type = "partition";
          start = "1MiB";
          end = "512MiB";
          bootable = true;
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot/efi";
            mountOptions = [
              "defaults"
            ];
          };
        }
        {
          name = "luks";
          type = "partition";
          start = "512MiB";
          end = "100%";
          content = {
            type = "luks";
            name = "crypted";
            extraArgs = ["--label" "root"];
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        }
      ];
    };
  };
  nodev."/" = {
    fsType = "tmpfs";
    mountOptions = [
      "size=2G"
      "defaults"
      "mode=755"
    ];
  };
  lvm_vg = {
    pool = {
      type = "lvm_vg";
      lvs = {
        nix = {
          type = "lvm_lv";
          size = "270G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/nix";
            extraArgs = ["-L" "nix"];
          };
        };
        persistent = {
          type = "lvm_lv";
          size = "200G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/nix/persist";
            extraArgs = ["-L" "persistent"];
          };
        };
      };
    };
  };
}
