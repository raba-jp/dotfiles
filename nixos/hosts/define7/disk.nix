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
          name = "root";
          start = "512MiB";
          end = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        }
      ];
    };
  };
}
