{ lib, pkgs, ... }:
let mkTuple = lib.hm.gvariant.mkTuple;
in
lib.mkIf (pkgs.stdenvNoCC.isLinux) {
  dconf.settings = {
    # Disable Super + P keybind
    "org/gnome/mutter/keybindings" = { switch-monitor = [ "XF86Display" ]; };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
      font-name = "Noto Sans CJK JP 11";
      monospace-font-name = "Noto Sans Mono CJK JP 10";
      document-font-name = "Noto Sans CJK JP 11";
    };
    "org/gnome/desktop/background" = {
      picture-uri =
        "file:///run/current-system/sw/share/backgrounds/gnome/Loveles.jpg";
    };
    "org/gnome/desktop/notifications" = { show-in-lock-screen = false; };
    "org/gnome/shell/extensions/user-theme" = { name = "Nordic-darker"; };

  };
}
