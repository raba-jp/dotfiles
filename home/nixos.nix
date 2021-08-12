{ pkgs, ... }: {
  home.username = "sakuraba";
  home.homeDirectory = "/home/sakuraba";

  imports = [ ./dconf.nix ];

  home.packages = with pkgs; [
    google-chrome
    obsidian
    flutter
    android-studio
    slack
    kube3d
    # Theme
    arc-theme
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
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };
}
