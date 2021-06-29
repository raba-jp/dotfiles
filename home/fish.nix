{ pkgs, ... }:

{
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
      set -U FZF_LEGACY_KEYBINDINGS 0

      bind \ck up-or-search
      bind \cj down-or-search
      bind \ch backward-char
      bind \cl forward-char
      bind \cs beginning-of-line
      bind \ce end-of-line
      bind \cm __done-enter
    '';

    plugins = [
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "1.16.2";
          sha256 = "08f103y0d71gfh6x3h8lwv269vhfkwmc9bahd321r2zwrvkz0xav";
        };
      }

      {
        name = "fish-ghq";
        src = pkgs.fetchFromGitHub {
          owner = "decors";
          repo = "fish-ghq";
          rev = "master";
          sha256 = "07jjrykxqvmyvq96qyd7wp6q90s9i6i9mv30gm6nkwxmcj2qk94k";
        };
      }

      {
        name = "fish-fzf";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "fzf";
          rev = "master";
          sha256 = "0k6l21j192hrhy95092dm8029p52aakvzis7jiw48wnbckyidi6v";
        };
      }

      {
        name = "bd";
        src = pkgs.fetchFromGitHub {
          owner = "0rax";
          repo = "fish-bd";
          rev = "master";
          sha256 = "1fifn0h6ib528yxsz0vky1qlny1rffvysbg7p1fdbyd0p0qs5pvw";
        };
      }
    ];

    shellAbbrs = {
      ls = "exa";
      ll = "exa -alhG";
      cat = "bat";
      grep = "rg";
      find = "fd";
      tree = "exa --tree";
      ps = "procs";
      untar = "tar -xzvf";
      repo =
        "cd (ghq list | fzf --select-1 | xargs echo $GOPATH/src/ | sed 's/ //')";
    };
  };
}
