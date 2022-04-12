{ pkgs, ... }:
let
  configFile = (builtins.replaceStrings [ "fish" ] [ "${pkgs.fish}/bin/fish" ] (builtins.readFile ./wezterm.lua));
in
{
  xdg.configFile."wezterm/wezterm.lua".text = configFile;
}
