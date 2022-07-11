{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    {
      dotfiles = {
        amd.enable = true;
        docker.enable = true;
        game.enable = true;
        gnome.enable = true;
        nextdns = {
          enable = true;
          filePath = config.sops.secrets.nextdnsConfiguration.path;
        };
        trackpad.enable = false;
        lxqt.enable = false;
        physical = {
          enable = true;
          boot.loader.useDefault = false;
          kernelPackages = pkgs.linuxPackages_5_15;
        };
      };
    }
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    grub = {
      efiSupport = true;
      enable = true;
      version = 2;
      devices = ["nodev"];
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root 6836-FD29
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  networking.hostName = "define7";

  security.pam = {
    u2f = {
      enable = true;
      control = "sufficient";
    };
  };

  sops = {
    secrets = {
      nextdnsConfiguration = {
        format = "binary";
        sopsFile = ../../secrets/nextdns-configuration;
      };

      cachixAgentToken = {
        format = "binary";
        sopsFile = ../../secrets/cachix-agent-token;
      };
    };
  };

  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
      config.users.groups.keys.name
    ];
    hashedPassword = "$6$pfJbTwMjGKRLZED.$E7VDlAVGg75bOgdnEo11Q9GCHH0M0RQk3VXlTotAxsE0EpypbiOAWbe8AsdwtgDCPbBtrSQ5zqrqYyX28qAO9.";
  };

  home-manager.users.sakuraba = {
    imports = [
      ../../home-manager/minimal.nix
      ../../home-manager/base.nix
      ../../home-manager/extends.nix
      ../../home-manager/kubernetes.nix
      ../../home-manager/linux.nix
      ../../home-manager/gtk
      ../../home-manager/dconf
      ../../home-manager/fish
      ../../home-manager/fzf
      ../../home-manager/git
      ../../home-manager/starship
      ../../home-manager/tig
      ../../home-manager/vim
      ../../home-manager/wezterm
    ];
  };
}
