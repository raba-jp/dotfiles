{ config, pkgs, ... }: {
  home-manager.useGlobalPkgs = true;

  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [ arc-theme materia-theme papirus-icon-theme ];
  };

  home-manager.users.sakuraba = { pkgs, ... }: {
    imports =
      [ /home/sakuraba/ghq/github.com/raba-jp/dotfiles/home-manager/home.nix ];
  };
}
