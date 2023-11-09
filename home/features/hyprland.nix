{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      $term = ${pkgs.wezterm}/bin/wezterm
      $browser = ${pkgs.brave}/bin/brave
      $filemanager=${pkgs.gnome.nautilus}/bin/nautilus
      $launcher=${pkgs.rofi-wayland}/bin/rofi

      exec-once=${pkgs.waybar}/bin/waybar

      animations {
        enabled = true
      }

      input {
        follow_mouse = true
        touchpad {
          natural_scroll=true
        }
      }

      bind = SUPER,T,exec,$term
      bind = SUPER,P,exec,$launcher
    '';
  };
}
