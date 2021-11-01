{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    aggressiveResize = true;

    keyMode = "vi";

    prefix = "C-q";

    shell = "${pkgs.fish}/bin/fish";
    terminal = "xterm-256color";

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.pain-control
      tmuxPlugins.battery
      tmuxPlugins.logging
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.nord;
        extraConfig = ''
          set -g @nord_tmux_no_patched_font "1"
        '';
      }
      {
        plugin = tmuxPlugins.sysstat;
        extraConfig = ''
          set-option -g status-left '#{prefix_highlight}#[fg=black,bg=blue,bold]#S'
          set-option -g status-right '#[fg=white,bg=brightblack] #{sysstat_cpu}#[fg=white,bg=brightblack,nobold,noitalics,nounderscore] |#[fg=white,bg=brightblack] #{sysstat_mem}#[fg=white,bg=brightblack,nobold,noitalics,nounderscore] |#[fg=white,bg=brightblack] #{sysstat_swap}#[fg=white,bg=brightblack] #[fg=black,bg=cyan,bold] #(echo $USER)#[fg=black,bg=cyan,bold]@#H '
        '';
      }
      {
        plugin = tmuxPlugins.prefix-highlight;
        extraConfig = ''
          set-option -g @prefix_highlight_show_copy_mode 'on'
          set-option -g @prefix_highlight_show_sync_mode 'on'
          set-option -g status-left '#{prefix_highlight}'
        '';

      }
    ];

    extraConfig = ''
      set-option -g monitor-activity on
      set-option -g visual-activity off
      set-option -g status-position top
      set-option -g status-left-length 120
      set-option -g status-right-length 120
      set-option -g monitor-activity on
      set-option -g visual-activity on
      set-option -g visual-bell on
      set-window-option -g mouse

      set-option -ga terminal-overrides ",xterm-256color:Tc"

      bind -T copy-mode-vi v send -X begin-selection

    '';
  };
}
