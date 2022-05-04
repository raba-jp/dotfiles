{ config, lib, pkgs, ... }:
lib.mkIf pkgs.stdenvNoCC.isLinux {
  home.packages = [ pkgs.swaylock ];

  wayland.windowManager.sway.config.keybindings =
    let
      mod = config.wayland.windowManager.sway.config.modifier;
    in
    lib.mkOptionDefault { "${mod}+x" = "exec swaylock"; };

  xdg.configFile."swaylock/config".text = ''
    daemonize
    scaling=fill
    bs-hl-color=bf616a
    caps-lock-bs-hl-color=bf616a
    caps-lock-key-hl-color=a3be8c
    font=UDEV Gothic
    font-size=16
    indicator-radius=60
    indicator-thickness=20
    inside-color=2e3440
    inside-clear-color=2e3440
    inside-wrong-color=2e3440
    inside-ver-color=2e3440
    key-hl-color=a3be8c
    line-uses-inside
    ring-color=8fbcbb
    ring-clear-color=ebcb8b
    ring-caps-lock-color=b48ead
    ring-ver-color=5e81ac
    ring-wrong-color=bf616a
    text-color=eceff4
    text-clear-color=eceff4
    text-caps-lock-color=e5e9f0
    text-ver-color=e5e9f0
    text-wrong-color=d8dee9
  '';
}
