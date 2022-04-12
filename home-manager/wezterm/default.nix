{ ... }:
let
  configFile = builtins.readFile ./wezterm.lua;
in
{
  xdg.configFile."wezterm/wezterm.lua".text = configFile;
}
