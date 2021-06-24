{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Hiroki Sakuraba";

    aliases = {
      tree =
        "log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'";
      branches = ''
        !git branch -a --sort=authordate | cut -b 3- | sed "s/remotes\/origin\///" | sort | uniq | rg -v -- "->" | fzf --select-1 | xargs git switch'';
      tags = "tag";
      stashes = "stash list";
      unstage = "reset -q HEAD --";
      discard = "checkout --";
      uncommit = "reset --mixed HEAD~";
      amend = "commit --amend";
      precommit = "diff --cached --diff-algorithm=minimal -w";
      remotes = "remote -v";
    };

    extraConfig = {
      core = {
        editor = "vim";
        preloadindex = true;
      };

      user = { useConfigOnly = true; };

      color = {
        status = "auto";
        diff = "auto";
        branch = "auto";
        interactive = "auto";
        grep = "auto";
      };

      pull.ff = "only";
    };

    ignores = [

      ".editorconfig"
      # direnv
      ".envrc"

      # macOS
      "*.DS_Store"
      ".AppleDouble"
      ".LSOverride"

      # Thumbnails
      "._*"

      # Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"

      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      # Linux
      "*~"

      # temporary files which can be created if a process still has a handle open of a deleted file
      ".fuse_hidden*"

      # KDE directory preferences
      ".directory"

      # Linux trash folder which might appear on any partition or disk
      ".Trash-*"

      # .nfs files are created when an open file is removed but is still being accessed
      ".nfs*"

      # Vim
      # swap
      "[._]*.s[a-v][a-z]"
      "[._]*.sw[a-p]"
      "[._]s[a-v][a-z]"
      "[._]sw[a-p]"
      # session
      "Session.vim"
      # temporary
      ".netrwhist"
      "*~"
      # auto-generated tag files
      "tags"

      ".vscode/tag"
    ];
  };
}
