{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "xps13";

  services = { power-profiles-daemon.enable = true; };

  environment.systemPackages = with pkgs; [ lm_sensors ];

  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
  };

  home-manager.users.sakuraba = import ../../home-manager;
}
