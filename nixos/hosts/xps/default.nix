{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    ./hardware-configuration.nix
    ../../common/global
    ../../common/optional/pipewire.nix
    ../../common/optional/systemd-boot.nix
    ../../common/optional/cachix.nix
    # ../../common/optional/libvirtd.nix
    ../../common/optional/hyprland.nix
    ../../common/optional/nm-applet.nix
    ../../common/optional/blueman.nix
    ../../common/users/sakuraba.nix
  ];

  networking.hostName = "xps";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      glxinfo
      libva-utils
      vulkan-tools
      google-chrome
      obsidian
      vscode
      papirus-icon-theme
      gparted
      flutter
      xclip
      dconf2nix
      libnotify
      lm_sensors
      bottles
      brave
      slack
      discord
      virt-manager
    ];

    disko.devices = {
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
                mountpoint = "/boot";
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
              size = "290G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
              };
            };
            persistent = {
              type = "lvm_lv";
              size = "200G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/persistent";
              };
            };
            swap = {
              type = "lvm_lv";
              size = "8G";
              content = {
                type = "swap";
              };
            };
          };
        };
      };
    };

    persistence."/persistent" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          parentDirectory = {mode = "u=rwx,g=,o=";};
        }
      ];
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
