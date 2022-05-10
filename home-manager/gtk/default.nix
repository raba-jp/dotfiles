{
  lib,
  pkgs,
  ...
}:
lib.mkIf pkgs.stdenvNoCC.isLinux {
  gtk = {
    enable = false;

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
