{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotfiles.yabai;
in {
  options.dotfiles.yabai = {
    enable = mkEnableOption "if you use yabai";
  };

  config = mkIf cfg.enable {
    services.yabai = {
      enable = cfg.enable;
      package = pkgs.yabai;
      config = {
        layout = "bsp";
        # padding
        top_padding = 30;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;

        window_placement = "second_child";
        window_topmost = "off";
        window_shadow = "off";
        window_opacity = "on";
        active_window_opacity = 1.0;
        normal_window_opacity = 0.7;
        window_border = "on";
        window_border_width = 6;
        active_window_border_color = "0x00000000";
        normal_window_border_color = "0xff555555";
        insert_feedback_color = "0xaad75f5f";
        split_ratio = 0.50;
        auto_balance = "on";
        mouse_modifier = "fn";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_follows_focus = "on";
        focus_follows_mouse = "autoraise";
      };
    };
  };
}
