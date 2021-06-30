{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
    obsidian
    flutter
    android-studio
    slack
    # Theme
    arc-theme
    materia-theme
    papirus-icon-theme
    adapta-gtk-theme
  ];
}
