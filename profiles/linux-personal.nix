{ pkgs, ... }: {
  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
    packages = with pkgs; [ materia-theme papirus-icon-theme ];
  };

  home-manager.users.sakuraba = { imports = [ ../../modules/home-manager ]; };
}
