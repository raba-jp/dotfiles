{pkgs, ...}: let
  configFile = builtins.replaceStrings ["/usr/local/bin/fish"] ["${pkgs.fish}/bin/fish"] (builtins.readFile ./wezterm.lua);
in {
  programs.wezterm = {
    enable = true;
    extraConfig = configFile;
  };
}
