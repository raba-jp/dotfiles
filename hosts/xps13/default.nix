{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    {
      dotfiles = {
        graphical.enable = true;
        game.enable = false;
        nvidia.enable = false;
      };
    }
  ];

  networking.hostName = "xps13";

  services = { power-profiles-daemon.enable = true; };

  environment.systemPackages = with pkgs; [ lm_sensors ];

  sops.secrets."cachix-agent-token" = {
    format = "binary";
    sopsFile = ../../secrets/xps13-cachix-agent-token;
  };

  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
  };

  home-manager.users.sakuraba = import ../../home-manager;
}
