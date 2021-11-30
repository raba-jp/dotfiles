{ pkgs, ... }: {
  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
  };

  home-manager.users.sakuraba = import ../modules/home-manager;
}
