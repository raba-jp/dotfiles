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
          kernelPackages = pkgs.linuxPackages_5_15;
        };
      };
    }
  ];

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
  };

  home-manager.users.sakuraba = import ../../home-manager;
}
