{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    {
      dotfiles = {
        graphical.enable = true;
        game.enable = true;
        nvidia.enable = true;
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

  sops.secrets."cachix-agent-token" = {
    format = "binary";
    sopsFile = ../../secrets/cachix-agent-token;
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
