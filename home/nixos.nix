{ pkgs, ... }: {
  home.username = "sakuraba";
  home.homeDirectory = "/home/sakuraba";

  home.packages = with pkgs; [
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
  ];

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
