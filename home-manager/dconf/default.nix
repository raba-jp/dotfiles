# REF: https://github.com/pop-os/shell/blob/master/scripts/configure.sh
{ lib, pkgs, ... }:
with lib.hm.gvariant;
lib.mkIf pkgs.stdenvNoCC.isLinux {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "Nordzy-cursors";
      document-font-name = "Noto Sans CJK JP 11";
      enable-animations = true;
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "Noto Sans CJK JP 11";
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Nordic-darker";
      icon-theme = "Papirus";
      monospace-font-name = "Noto Sans Mono CJK JP 10";
      show-battery-percentage = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri =
        "file:///run/current-system/sw/share/backgrounds/gnome/Loveles.jpg";
    };
    "org/gnome/desktop/notifications" = { show-in-lock-screen = false; };
    "org/gnome/shell/extensions/user-theme" = { name = "Nordic-darker"; };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" "<Alt>F4" ]; # Close Window
      # Maximize window: disable <Super>Up
      maximize = [ ];
      # Hide window: disable <Super>h
      minimize = [ "<Super>comma" ];
      # Move to monitor down: disable <Super><Shift>Down
      move-to-monitor-down = [ ];
      # Move window one monitor to the left
      move-to-monitor-left = [ ];
      # Move window one monitor to the right
      move-to-monitor-right = [ ];
      # Move to monitor up: disable <Super><Shift>Up
      move-to-monitor-up = [ ];
      # Move window one workspace down
      move-to-workspace-down = [ ];
      # Move window one workspace up
      move-to-workspace-up = [ ];
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
      # Move to workspace below
      switch-to-workspace-down = [ "<Primary><Super>Down" "<Primary><Super>j" ];
      # Switch to workspace left: disable <Super>Left
      switch-to-workspace-left = [ ];
      # Switch to workspace right: disable <Super>Right
      switch-to-workspace-right = [ ];
      # Move to workspace above
      switch-to-workspace-up = [ "<Primary><Super>Up" "<Primary><Super>k" ];
      switch-windows = [ "<Super>Tab" ];
      switch-windows-backward = [ "<Shift><Super>Tab" ];
      # Toggle maximization state
      toggle-maximized = [ "<Super>m" ];
      # Restore window: disable <Super>Down
      unmaximize = [ ];
    };

    "org/gnome/mutter/keybindings" = {
      # Disable Super + P
      switch-monitor = [ "XF86Display" ];
      # Disable tiling to left / right of screen
      toggle-tiled-left = [ ];
      toggle-tiled-right = [ ];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      # Restore the keyboard shortcuts: disable <Super>Escape
      restore-shortcuts = [ ];
    };

    "org/gnome/shell/keybindings" = {
      # Open the application menu: disable <Super>m
      open-application-menu = [ ];
      # Toggle message tray: disable <Super>m
      toggle-message-tray = [ "<Super>v" ];
      # Show the activities overview: disable <Super>s
      toggle-overview = [ ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      email = [ "<Super>e" ];
      home = [ "<Super>f" ];
      rotate-video-lock-static = [ ];
      screensaver = [ "<Super>Escape" ];
      terminal = [ "<Super>t" ];
      www = [ "<Super>b" ];
    };
  };
}
