{ pkgs, ... }: {
  imports = [ ../home-manager/personal.nix ./home-manager.nix ];
  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [ materia-theme papirus-icon-theme ];
  };
}
