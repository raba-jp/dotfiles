# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "org/gnome/control-center" = {
      last-panel = "background";
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///nix/store/gg4ah533kjknnm9q8d6v4vsgcawlxjhk-gnome-backgrounds-40.1/share/backgrounds/gnome/IceCrystals.jpg";
      primary-color = "#ffffff";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/input-sources" = {
      current = "uint32 0";
      per-window = false;
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "ctrl:nocaps" ];
    };

    "org/gnome/desktop/interface" = {
      cursor-theme = "Adwaita";
      document-font-name = "Noto Sans CJK JP 11";
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "Noto Sans CJK JP 11";
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Materia-dark-compact";
      icon-theme = "Papirus";
      monospace-font-name = "Noto Sans Mono CJK JP 10";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "fish" "gnome-power-panel" "obsidian" "google-chrome" ];
    };

    "org/gnome/desktop/notifications/application/fish" = {
      application-id = "fish.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/google-chrome" = {
      application-id = "google-chrome.desktop";
    };

    "org/gnome/desktop/notifications/application/obsidian" = {
      application-id = "obsidian.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      edge-scrolling-enabled = false;
      speed = 1.0;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      report-technical-problems = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///nix/store/gg4ah533kjknnm9q8d6v4vsgcawlxjhk-gnome-backgrounds-40.1/share/backgrounds/gnome/IceCrystals.jpg";
      primary-color = "#ffffff";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [];
      switch-applications-backward = [];
      switch-input-source = [];
      switch-input-source-backward = [];
      switch-windows = [ "<Super>Tab" ];
      switch-windows-backward = [ "<Shift><Super>Tab" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Noto Sans CJK JP Bold 11";
    };

    "org/gnome/epiphany/state" = {
      is-maximized = false;
      window-position = mkTuple [ (-1) (-1) ];
      window-size = mkTuple [ 1024 768 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
      network-monitor-gio-name = "";
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 480;
      window-width = 600;
    };

    "org/gnome/gnome-system-monitor" = {
      cpu-colors = [ (mkTuple [ "uint32 0" "#e6194B" ]) (mkTuple [ 1 "#f58231" ]) (mkTuple [ 2 "#ffe119" ]) (mkTuple [ 3 "#bfef45" ]) (mkTuple [ 4 "#3cb44b" ]) (mkTuple [ 5 "#42d4f4" ]) (mkTuple [ 6 "#4363d8" ]) (mkTuple [ 7 "#911eb4" ]) (mkTuple [ 8 "#f032e6" ]) (mkTuple [ 9 "#fabebe" ]) (mkTuple [ 10 "#ffd8b1" ]) (mkTuple [ 11 "#fffac8" ]) (mkTuple [ 12 "#aaffc3" ]) (mkTuple [ 13 "#469990" ]) (mkTuple [ 14 "#000075" ]) (mkTuple [ 15 "#e6beff" ]) (mkTuple [ 16 "#f25915e815e8" ]) (mkTuple [ 17 "#f25915e815e8" ]) (mkTuple [ 18 "#f25915e815e8" ]) (mkTuple [ 19 "#f25915e815e8" ]) (mkTuple [ 20 "#f25915e815e8" ]) (mkTuple [ 21 "#f25915e815e8" ]) (mkTuple [ 22 "#f25915e815e8" ]) (mkTuple [ 23 "#f25915e815e8" ]) ];
      current-tab = "resources";
      maximized = false;
      network-total-in-bits = false;
      show-dependencies = true;
      show-whose-processes = "user";
      window-state = mkTuple [ 1354 957 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
      maximized = false;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = true;
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      app-picker-view = "uint32 1";
      disable-user-extensions = true;
      disabled-extensions = [ "native-window-placement@gnome-shell-extensions.gcampax.github.com" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "auto-move-windows@gnome-shell-extensions.gcampax.github.com" "bluetooth-quick-connect@bjarosze.gmail.com" "clipboard-indicator@tudmotu.com" "switcher@landau.fi" ];
      enabled-extensions = [ "sensory-perception@HarlemSquirrel.github.io" "user-theme@gnome-shell-extensions.gcampax.github.com" ];
      favorite-apps = [ "org.gnome.Nautilus.desktop" "google-chrome.desktop" "gnome-system-monitor.desktop" "Alacritty.desktop" "obsidian.desktop" "code.desktop" ];
      had-bluetooth-devices-setup = true;
      welcome-dialog-last-shown-version = "40.1";
    };

    "org/gnome/shell/extensions/switcher" = {
      activate-after-ms = "uint32 0";
      activate-immediately = true;
      fade-enable = true;
      font-size = "uint32 18";
      icon-size = "uint32 32";
      launcher-stats = "'{"Alacritty.desktop":1,"google-chrome.desktop":1}'";
      matching = "uint32 1";
      max-width-percentage = "uint32 40";
      on-active-display = false;
      show-executables = true;
      show-switcher = [ "<Super>space" ];
      workspace-indicator = false;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Materia-dark-compact";
    };

    "org/gnome/shell/world-clocks" = {
      locations = "@av []";
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 181;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 2264 83 ];
      window-size = mkTuple [ 1231 902 ];
    };

  };
}
