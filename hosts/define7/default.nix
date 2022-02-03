{ pkgs, ... }: {
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

  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
  };

  home-manager.users.sakuraba = import ../../home-manager;
}
