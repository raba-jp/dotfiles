{ pkgs, ... }: {
  imports = [ ./plugins.nix ];

  programs.tmux = {
    enable = true;

    aggressiveResize = true;

    keyMode = "vi";

    prefix = "C-q";

    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";

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
