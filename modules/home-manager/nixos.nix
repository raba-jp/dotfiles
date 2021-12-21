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
      vscode
      xclip
      dconf2nix
      glxinfo
      appimagekit
      stack
      gnome3.dconf-editor
      # Theme
      papirus-icon-theme
      nordic
      materia-theme
      papirus-icon-theme
    ];
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
  };
}
