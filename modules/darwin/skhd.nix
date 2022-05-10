{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.skhd;
in {
  options.dotfiles.skhd = {
    enable = mkEnableOption "if you use skhd";
  };

  config = mkIf cfg.enable {
    services.skhd = {
      enable = cfg.enable;
      skhdConfig = ''
        # focus window
        alt - x : yabai -m window --focus recent
        alt - h : yabai -m window --focus west
        alt - j : yabai -m window --focus south
        alt - k : yabai -m window --focus north
        alt - l : yabai -m window --focus east
        alt - z : yabai -m window --focus stack.prev
        alt - c : yabai -m window --focus stack.next

        # swap window
        shift + alt - x : yabai -m window --swap recent
        shift + alt - h : yabai -m window --swap west
        shift + alt - j : yabai -m window --swap south
        shift + alt - k : yabai -m window --swap north
        shift + alt - l : yabai -m window --swap east

        # move window
        shift + cmd - h : yabai -m window --warp west
        shift + cmd - j : yabai -m window --warp south
        shift + cmd - k : yabai -m window --warp north
        shift + cmd - l : yabai -m window --warp east

        # move window
        shift + ctrl - a : yabai -m window --move rel:-20:0
        shift + ctrl - s : yabai -m window --move rel:0:20
        shift + ctrl - w : yabai -m window --move rel:0:-20
        shift + ctrl - d : yabai -m window --move rel:20:0

        # increase window size
        shift + alt - a : yabai -m window --resize left:-20:0
        shift + alt - s : yabai -m window --resize bottom:0:20
        shift + alt - w : yabai -m window --resize top:0:-20
        shift + alt - d : yabai -m window --resize right:20:0

        # decrease window size
        shift + cmd - a : yabai -m window --resize left:20:0
        shift + cmd - s : yabai -m window --resize bottom:0:-20
        shift + cmd - w : yabai -m window --resize top:0:20
        shift + cmd - d : yabai -m window --resize right:-20:0

        # rotate tree
        alt - r : yabai -m space --rotate 90

        # mirror tree y-axis
        alt - y : yabai -m space --mirror y-axis

        # mirror tree x-axis
        alt - x : yabai -m space --mirror x-axis

        # toggle desktop offset
        alt - a : yabai -m space --toggle padding && yabai -m space --toggle gap

        # toggle window fullscreen zoom
        alt - f : yabai -m window --toggle zoom-fullscreen

        # toggle window native fullscreen
        shift + alt - f : yabai -m window --toggle native-fullscreen

        # toggle window split type
        alt - e : yabai -m window --toggle split

        # float / unfloat window and restore position
        # alt - t : yabai -m window --toggle float && /tmp/yabai-restore/$(yabai -m query --windows --window | jq -re '.id').restore 2>/dev/null || true
        alt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
      '';
    };
  };
}
