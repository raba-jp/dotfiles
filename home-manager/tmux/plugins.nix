{ pkgs, ... }: {
  programs.tmux.plugins = with pkgs; [
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
}
