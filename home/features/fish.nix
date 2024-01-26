{
  pkgs,
  inputs,
  ...
}: {
  xdg.configFile = {
    "fish/themes/Rosé Pine Moon.theme" = {
      text = builtins.readFile (inputs.rose-pine-fish + "/themes/Rosé Pine Moon.theme");
      onChange = "${pkgs.fish}/bin/fish -c 'yes | fish_config theme save \"Rosé Pine Moon\"'";
    };
  };

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
      ${pkgs.mise}/bin/mise activate fish | source

      if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end
    '';

    # https://github.com/LnL7/nix-darwin/issues/122
    loginShellInit = ''
      fish_add_path --move --prepend --path $HOME/.nix-profile/bin /run/wrappers/bin /etc/profiles/per-user/$USER/bin /run/current-system/sw/bin

      set -U FZF_LEGACY_KEYBINDINGS 0
      set -U GHQ_SELECTOR "fzf-tmux"
      set -U GHQ_SELECTOR_OPTS "-w 80% -h 50% --"
      set -U FZF_TMUX_OPTS "-w 80% -h 50%"
    '';

    shellAliases = {
      ls = "eza";
      ll = "eza --all --long --grid --header --no-filesize --no-time --no-user --git --icons";
      tree = "eza --tree --icons --all --git-ignore --ignore-glob=.git";
      cat = "bat";
    };

    shellAbbrs = {
      gc = "git commit";
      guc = "git uncommit";
      gs = "git status --short";
      grep = "rg";
      find = "fd";
      ps = "procs";
      untar = "tar -xvf";
      xclip = "xclip -selection clipboard";
      q = "pueue";
      man = "batman";
    };

    plugins = [
      {
        name = "done";
        src = inputs.fish-done;
      }
      {
        name = "fish-ghq";
        src = inputs.fish-ghq;
      }
      {
        name = "fish-fzf";
        src = inputs.fish-fzf;
      }
    ];
  };
}
