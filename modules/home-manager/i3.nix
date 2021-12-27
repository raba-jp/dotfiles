{ config, pkgs, lib, ... }:
let
  modifier = config.xsession.windowManager.i3.config.modifier;
  cfg = {
    dpi = 192;
    monitor = "DP-0";
    width = "100%";
    height = "3%";
    offsetX = 0;
    offsetY = 0;
    radius = 0;
    fixedCenter = true;
  };

  colors = {
    background = "#2E3440";
    buffer = "#4c566a";
    foreground = "#D8DEE9";
    nord6 = "#ECEFF4";
    nord7 = "#8FBCBB";
    nord8 = "#88C0D0";
    nord9 = "#81A1C1";
    urgent = "#BF616A";
    warning = "#D08770";
    notify = "#EBCB8B";
    success = "#A3BE8C";
    function = "#B48EAD";
  };
in
lib.mkIf (pkgs.stdenvNoCC.isLinux) {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = [ ];
      colors = {
        focused = {
          border = "#81a1c1";
          childBorder = "#81a1c1";
          background = "#81a1c1";
          text = "#ffffff";
          indicator = "#81a1c1";
        };

        unfocused = {
          border = "#2e3440";
          childBorder = "#2e3440";
          background = "#2e3440";
          text = "#888888";
          indicator = "#2e3440";
        };

        focusedInactive = {
          border = "#2e3440";
          childBorder = "#2e3440";
          background = "#2e3440";
          text = "#888888";
          indicator = "#2e3440";
        };

        placeholder = {
          border = "#2e3440";
          childBorder = "#2e3440";
          background = "#2e3440";
          text = "#888888";
          indicator = "#2e3440";
        };

        urgent = {
          border = "#900000";
          childBorder = "#900000";
          background = "#900000";
          text = "#ffffff";
          indicator = "#900000";
        };

        background = "#242424";
      };

      keybindings = {
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+space" = "exec ${pkgs.rofi}/bin/rofi -show run -dpi 180";
      };

      menu = "${pkgs.rofi}/bin/rofi -show run -dpi 180";
      terminal = "${pkgs.kitty}/bin/kitty";

    };
  };

  programs.rofi.enable = true;
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };
    config = {
      "bar/top" = {
        monitor = "DP-0";
        width = "100%";
        height = "2%";
        radius = 0;
        "modules-right" = "datetime";
      };

      "bar/base" = {
        theme = "dark";
        monitor = cfg.monitor;
        width = cfg.width;
        height = cfg.height;
        offset-x = cfg.offsetX;
        offset-y = cfg.offsetY;
        radius = cfg.radius;
        fixed-center = cfg.fixedCenter;
        dpi = cfg.dpi;

        background = colors.background;
        foreground = colors.foreground;
      };

      # line-size = ${config.line-size}
      # 
      # padding = 0
      # override-redirect = ${config.override-redirect}
      # wm-restack = ${config.wm-restack}
      # 
      # tray-padding = 3
      # tray-detached = false
      # tray-maxsize = 22
      # 
      # cursor-click = pointer
      # cursor-scroll = ns-resize
      # 
      # enable-ipc = true
      # 
      # [bar/nord-top]
      # inherit = bar/base
      # 
      # module-margin = 1
      # 
      # font-0 = WenQuanYiMicroHei:size=12
      # font-1 = FontAwesome5FreeSolid:pixelsize=12;1
      # font-2 = FontAwesome5FreeRegular:pixelsize=12;1
      # font-3 = FontAwesome5Brands:pixelsize=8;1
      # font-4 = FiraCodeRegular:pixelsize=12
      # 
      # modules-left = ${config.top-left}
      # modules-center = ${config.top-center}
      # modules-right = ${config.top-right}
      # 
      # tray-position = ${config.systray-top}
      # 
      # [bar/nord-down]
      # inherit = bar/base
      # 
      # bottom = true
      # 
      # module-margin = 2
      # 
      # font-0 = WenQuanYiMicroHei:size=12
      # font-1 = FontAwesome5FreeSolid:pixelsize=12;1
      # font-2 = FontAwesome5Brands:pixelsize=8;1
      # font-3 = Weather Icons:style=Regular:size=12;1
      # font-4 = FiraCodeRegular:pixelsize=12
      # 
      # modules-left = ${config.bottom-left}
      # modules-center = ${config.bottom-center}
      # modules-right = ${config.bottom-right}
      # 
      # tray-position = ${config.systray-bottom}
    };
    script = ''
      polybar top &
    '';
  };
}
