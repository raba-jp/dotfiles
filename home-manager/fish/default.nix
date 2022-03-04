{ pkgs, ... }: {
  imports = [ ./plugins.nix ];

  programs.fish = {
    enable = true;

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

      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

      if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end
    '';

    # https://github.com/LnL7/nix-darwin/issues/122
    loginShellInit = ''
      fish_add_path --move --prepend --path $HOME/.nix-profile/bin /run/wrappers/bin /etc/profiles/per-user/$USER/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin

      set -U FZF_LEGACY_KEYBINDINGS 0
      set -U GHQ_SELECTOR "fzf-tmux"
      set -U GHQ_SELECTOR_OPTS "-w 80% -h 50% --"
      set -U FZF_TMUX_OPTS "-w 80% -h 50%"
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
