{ pkgs, lib, ... }:
lib.mkIf (pkgs.stdenvNoCC.isLinux) {
  home = {
    username = "sakuraba";
    homeDirectory = "/home/sakuraba";

    packages = with pkgs; [
      google-chrome
      obsidian
      flutter
      android-studio
      slack
      kube3d
      # Theme
      papirus-icon-theme
      vscode
      xclip
      dconf2nix
      factorio
      glxinfo
    ];
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Materia-dark-compact";
      package = pkgs.materia-theme;
    };
  };
}
