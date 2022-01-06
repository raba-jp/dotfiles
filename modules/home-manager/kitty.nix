{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.cica;
      name = "Cica";
    };

    keybindings = {
      # window
      "ctrl+q>-" = "launch --cwd=current --location=default";
      "ctrl+q>q" = "next_window";
      "ctrl+q>a" = "previous_window";
      # tab
      "ctrl+q>t" = "launch --cwd=current --type=tab";
      "ctrl+q>n" = "next_tab";
      "ctrl+q>p" = "previous_tab";
      # layout
      "ctrl+q>space" = "next_layout";
      # clipboard
      "ctrl+q>c" = "copy_to_clipboard";
      "ctrl+q>v" = "paste_from_clipboard";
      # Font size
      "ctrl+shift+equal" = "change_font_size all +2.0";
      "ctrl+shift+plus" = "change_font_size all +2.0";
      "ctrl+shift+minus" = "change_font_size all -2.0";
      # scrollback
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+j" = "scroll_line_down";
      # Browse scrollback buffer in less 
      "ctrl+q>h" = "show_scrollback";
      "f1" =
        "launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay bat";
    };
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = (if pkgs.stdenvNoCC.isDarwin then 16 else 12);
      scrollback_lines = 10000;
      copy_on_select = "yes";
      strip_trailing_spaces = "smart";
      sync_to_monitor = "yes";
      enable_audio_bell = "no";
      remember_window_size = "no";
      initial_window_width = 1280;
      initial_window_height = 720;
      macos_titlebar_color = "background";
      macos_option_as_alt = "yes";
      macos_quit_when_last_window_closed = "yes";
      term = "xterm-256color";
      shell = "${pkgs.zsh}/bin/zsh --login";
      # shell = "/etc/profiles/per-user/sakuraba/bin/zsh --login";
      enabled_layouts = "grid,fat,horizontal,splits,tall,vertical";
      window_padding_width = 2;
      single_window_margin_width = 2;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      # kitty_mod = "ctrl+shift";
      clear_all_shortcuts = "yes";
      # Nord
      foreground = "#d8dee9";
      background = "#2e3440";
      selection_foreground = "#d8dee9";
      selection_background = "#3b4252";
      mark1_foreground = "#d08770";
      mark2_foreground = "#d08770";
      mark3_foreground = "#d08770";
      url_color = "#e5e9f0";
      cursor = "#d8dee9";
      cursor_text_color = "#4c566a";
      active_tab_foreground = "#e5e9f0";
      active_tab_background = "#4c566a";
      inactive_tab_foreground = "#d8dee9";
      inactive_tab_background = "#3b4252";
      color0 = "#3b4252";
      color1 = "#bf616a";
      color2 = "#a3be8c";
      color3 = "#ebcb8b";
      color4 = "#81a1c1";
      color5 = "#b48ead";
      color6 = "#88c0d0";
      color7 = "#e5e9f0";
      color8 = "#4c566a";
      color9 = "#bf616a";
      color10 = "#a3be8c";
      color11 = "#ebcb8b";
      color12 = "#81a1c1";
      color13 = "#b48ead";
      color14 = "#88c0d0";
      color15 = "#e5e9f0";
    };
  };
}
