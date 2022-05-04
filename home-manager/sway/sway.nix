{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenvNoCC.isLinux {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # systemdIntegration = true;

    config = {
      terminal = "${pkgs.wezterm}/bin/wezterm";
      menu = "${pkgs.wofi}/bin/wofi --show drun";
      bars = [ ];
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    dmenu
    wofi
  ];
}
