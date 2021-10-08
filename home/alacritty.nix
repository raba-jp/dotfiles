{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";

      window = {
        decorations = "none";
        startup_mode = "Maximized";
      };

      font = {
        normal = {
          family = "Cica";
          style = "Regular";
        };
        bold = {
          family = "Cica";
          style = "Bold";
        };
        italic = {
          family = "Cica";
          style = "Italic";
        };
        use_thin_stroke = true;
      };

      # solarized dark
      # colors = {
      #   primary = {
      #     background = "0x002b36";
      #     foreground = "0x839496";
      #   };
      #   normal = {
      #     black = "0x073642";
      #     red = "0xdc322f";
      #     green = "0x859900";
      #     yellow = "0xb58900";
      #     blue = "0x268bd2";
      #     magenta = "0xd33682";
      #     cyan = "0x2aa198";
      #     white = "0xeee8d5";
      #   };
      #   bright = {
      #     black = "0x002b36";
      #     red = "0xcb4b16";
      #     green = "0x586e75";
      #     yellow = "0x657b83";
      #     blue = "0x839496";
      #     magenta = "0x6c71c4";
      #     cyan = "0x93a1a1";
      #     white = "0xfdf6e3";
      #   };
      # };

      # nord
      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
          dim_foreground = "#a5abb6";
        };

        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };

        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };

        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };

        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };
          bar = {
            background = "#434c5e";
            foreground = "#d8dee9";
          };
        };

        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };

        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };

        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
      };

      bell = {
        animation = "Ease";
        duration = 0;
        color = "#ffffff";
      };

      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };

      live_config_reload = true;

      key_bindings = [
        {
          key = "Q";
          mods = "Control";
          chars = "\\x11";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Equals";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        # Linux only
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        # macOS only
        {
          key = "V";
          mods = "Command";
          action = "Paste";
        }
        {
          key = "C";
          mods = "Command";
          action = "Copy";
        }
      ];
    };
  };
}
