{ pkgs, ... }: {
  programs.kitty.keybindings = {
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
    "f1" = "launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay bat";
  };
}
