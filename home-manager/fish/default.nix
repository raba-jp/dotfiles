{ pkgs, ... }: {
  imports = [ ./plugins.nix ];

  programs.fish = {
    enable = false;

    functions = {
      __done-enter = ''
          if [ -z (commandline) ]
            if git rev-parse --is-inside-work-tree > /dev/null 2>&1
              echo
              echo
        echo (set_color yellow)"---------- Git status ----------"(set_color normal)
              git status --short --branch
              echo
              echo
            end
          else
            commandline -f execute
          end
          commandline -f repaint
      '';
    };

    interactiveShellInit = ''
      bind \ck up-or-search
      bind \cj down-or-search
      bind \ch backward-char
      bind \cl forward-char
      bind \cs beginning-of-line
      bind \ce end-of-line
      bind \cm __done-enter
    '';

    loginShellInit = ''
      set -U FZF_LEGACY_KEYBINDINGS 0
      set -U GHQ_SELECTOR "fzf-tmux"
      set -U GHQ_SELECTOR_OPTS "-w 80% -h 50% --"
      set -U FZF_TMUX_OPTS "-w 80% -h 50%"
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      end
      if test -e /etc/static/bashrc
        fenv source /etc/static/bashrc
      end
    '';

    shellAbbrs = {
      ls = "exa";
      ll = "exa -alhG";
      cat = "bat";
      grep = "rg";
      find = "fd";
      tree = "exa --tree";
      ps = "procs";
      untar = "tar -xzvf";
      xclip = "xclip -selection clipboard";
    };
  };
}
