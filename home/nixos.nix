{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
    obsidian
    flutter
    android-studio
    slack
    # Theme
    arc-theme
    papirus-icon-theme
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };
}
