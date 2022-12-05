{pkgs, ...}: let
  configFile = builtins.replaceStrings ["$SHELL"] ["${pkgs.fish}/bin/fish"] (builtins.readFile ./wezterm.lua);
in {
  programs.wezterm = {
    enable = true;
    extraConfig = configFile;
  };
}
