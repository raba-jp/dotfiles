{pkgs, ...} @ args: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      bind \ck up-or-search
      bind \cj down-or-search
      bind \ch backward-char
      bind \cl forward-char
      bind \cs beginning-of-line
      bind \ce end-of-line

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
      ll = "exa --all --long --grid --header --no-filesize --no-time --no-user --git --icons";
      gc = "git commit";
      guc = "git uncommit";
      gs = "git status --short";
      cat = "bat";
      grep = "rg";
      find = "fd";
      tree = "exa --tree --icons --all --git-ignore --ignore-glob=.git";
      ps = "procs";
      untar = "tar -xvf";
      xclip = "xclip -selection clipboard";
    };

    plugins = [
      {
        name = "done";
        src = args.fish-done;
      }
      {
        name = "fish-ghq";
        src = args.fish-ghq;
      }
      {
        name = "fish-fzf";
        src = args.fish-fzf;
      }
    ];
  };
}
