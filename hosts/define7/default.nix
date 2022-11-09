{config, ...}: {
  imports = [
    ./hardware-configuration.nix
    {
      dotfiles = {
        network.hostName = "define7";
        services = {
          mediaServer.enable = true;
          cachixAgent.enable = true;
        };
        amd.enable = true;
        docker.enable = true;
        game.enable = true;
        gnome.enable = true;
        nextdns = {
          enable = false;
        };
        trackpad.enable = false;
        lxqt.enable = false;
        physical = {
          enable = true;
        };
      };
    }
  ];

  # boot.loader = {
  #   efi = {
  #     canTouchEfiVariables = true;
  #     efiSysMountPoint = "/boot";
  #   };

  #   grub = {
  #     efiSupport = true;
  #     enable = true;
  #     version = 2;
  #     devices = ["nodev"];
  #     extraEntries = ''
  #       menuentry "Windows" {
  #         insmod part_gpt
  #         insmod fat
  #         insmod search_fs_uuid
  #         insmod chain
  #         search --fs-uuid --set=root 6836-FD29
  #         chainloader /EFI/Microsoft/Boot/bootmgfw.efi
  #       }
  #     '';
  #   };
  # };

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
      ../../home-manager/wezterm
      ../../home-manager/helix
      ../../home-manager/gitui
      ../../home-manager/espanso
    ];
  };
}
