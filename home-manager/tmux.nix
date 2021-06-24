{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    keyMode = "vi";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.pain-control
      tmuxPlugins.battery
      tmuxPlugins.logging
      {
        plugin = tmuxPlugins.sysstat;
        extraConfig =
          "set-option -g status-right '#{sysstat_cpu} | #{sysstat_mem} | #{sysstat_swap} | #{sysstat_loadavg} | #[fg=cyan]#(echo $USER)#[default]@#H'";
      }
      {
        plugin = tmuxPlugins.prefix-highlight;
        extraConfig = ''
          set-option -g @prefix_highlight_show_copy_mode 'on'
          set-option -g @prefix_highlight_show_sync_mode 'on'
          set-option -g status-left '#{prefix_highlight}'
        '';

      }
      {
        plugin = tmuxPlugins.tmux-colors-solarized;
        extraConfig = "set -g @colors-solarized 'dark'";
      }
    ];
    prefix = "C-q";
    shell = "${pkgs.fish}/bin/fish";

    extraConfig = ''
      set-option -g status-position top
      set-option -g status-left-length 120
      set-option -g status-right-length 120
      set-option -g monitor-activity on
      set-option -g visual-activity on
      set-option -g visual-bell on
      set-window-option -g window-status-format '#P: #W'
      set-window-option -g window-status-current-format '#P: #W'
      set-window-option -g mouse

      bind -T copy-mode-vi v send -X begin-selection

    '';
  };
}
