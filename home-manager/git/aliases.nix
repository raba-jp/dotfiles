_: {
  programs.git.aliases = {
    tree = "log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'";
    branches = ''
      !git branch -a --sort=authordate | cut -b 3- | sed "s/remotes\/origin\///" | sort | uniq | rg -v -- "->" | fzf-tmux -w 80% -h 50% | xargs git switch'';
    tags = "tag";
    stashes = "stash list";
    unstage = "reset -q HEAD --";
    discard = "checkout --";
    uncommit = "reset --mixed HEAD~";
    amend = "commit --amend";
    precommit = "diff --cached --diff-algorithm=minimal -w";
    remotes = "remote -v";
  };
}
