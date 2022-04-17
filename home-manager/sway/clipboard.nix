{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    clipman
    wl-clipboard
    wofi
  ];

  systemd.user.services.clipman = {
    Unit = {
      Description = "Clipboard manager for Wayland";
      Documentation = [ "https://github.com/yory8/clipman" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };

    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store
      '';
    };
  };

  wayland.windowManager.sway.config.keybindings =
    let mod = config.wayland.windowManager.sway.config.modifier;
    in lib.mkOptionDefault { "${mod}+p" = "exec ${pkgs.clipman}/bin/clipman pick -t wofi"; };
}
