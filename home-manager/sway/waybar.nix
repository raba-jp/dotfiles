{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenvNoCC.isLinux {
  programs.waybar = {
    enable = true;

    style = builtins.readFile ./style.css;
    # systemd.enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 24;
      #
      #      modules-left = [
      #        "sway/workspaces"
      #        "sway/mode"
      #        "sway/window"
      #      ];
      #
      #      modules-right = [
      #        # "cpu"
      #        # "memory"
      #        # "disk"
      #        "network"
      #        "pulseaudio"
      #        "backlight"
      #        "battery"
      #        "clock"
      #      ];
      #
      #      cpu = {
      #        interval = 11;
      #        format = "﬙ {usage}% {load}";
      #      };
      #
      #      memory = {
      #        interval = 13;
      #        format = " {used:0.1f}/{total:0.1f}GiB";
      #      };
      #
      #      disk = {
      #        interval = 127;
      #        format = " {used}/{total}";
      #      };
      #
      #      network = {
      #        format-ethernet = " {signalStrength} {essid}";
      #        format-wifi = "﬉ {signalStrength} {essid}";
      #        format-disconnected = " {ifname} disconnected";
      #      };
      #
      #      pulseaudio = {
      #        scroll-step = 2;
      #        format = "{icon} {volume}%";
      #        format-bluetooth = "{icon} {volume}% ";
      #        format-muted = "🔇 {volume}%";
      #
      #        format-icons = {
      #          default = [ "" "" ];
      #          headphone = [ "" "" ];
      #          headset = "";
      #          phone = "";
      #          speaker = [ "🔈" "🔉" "🔊" ];
      #        };
      #      };
      #
      #      backlight = {
      #        format = "{icon} {percent}%";
      #        format-icons = [ "○" "◍" "●" ];
      #      };
      #
      #      battery = {
      #        interval = 23;
      #        format = "{icon} {capacity}% {time}";
      #        format-charging = " {capacity}% {time}";
      #        format-time = " {H}:{M}";
      #        format-icons = [ "" "" "" "" "" "" "" "" "" "" "" ];
      #      };
      #
      #      clock = {
      #        format = " {:%Y-%m-%dT%H:%M}";
      #        today-format = "{%Y-%m-%d}";
      #      };
    }];
  };
}
