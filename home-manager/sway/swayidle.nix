{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenvNoCC.isLinux {
  services.swayidle = {
    enable = true;

    events = [
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock"; }
      { event = "before-sleep"; command = "${pkgs.playerctl}/bin/playerctl pause"; }
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock"; }
      { event = "after-resume"; command = "${pkgs.sway}/bin/swaymsg 'output * dpms on'"; }
    ];

    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
      {
        timeout = 605;
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
  };
}
