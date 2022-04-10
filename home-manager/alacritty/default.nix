{ pkgs, ... }: {
  imports = [
    ./colorscheme/nord.nix
    ./keybindings.nix
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";

      window = {
        startup_mode = "Windowed";
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
        size = 14;
        use_thin_stroke = true;
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
    };
  };
}
