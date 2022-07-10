{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenvNoCC) isLinux;
  inherit (lib) mkIf;
in
  mkIf isLinux {
    home.packages = with pkgs; [
      # yubikey-personalization-gui
      gcc
      wezterm
      jetbrains.idea-community
    ];
  }
