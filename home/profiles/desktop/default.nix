{pkgs, ...}: {
  imports = [
    ../minimal

    ./zed
    ./wezterm
  ];

  home.sessionVariables.EDITOR = "zed";

  home.packages = with pkgs; [
    devcontainer
    ghq
  ];

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    delta.enable = true;

    userName = "Hiroki Sakuraba";

    extraConfig = {
      credential."https://github.com".helper = "!gh auth git-credential";

      core = {
        multipackindex = true;
        preloadindex = true;
        untrackedcache = true;
      };

      gc.auto = 0;
      gui.gcwarning = false;
      index.threads = true;
      index.version = 4;
      merge.stat = false;
      merge.renames = true;
      pack.usebitmaps = false;
      pack.usesparse = true;
      receive.autogc = false;
      feature.manyfiles = false;
      feature.experimental = false;
      fetch.unpacklimit = 1;
      fetch.writecommitgraph = false;
      fetch.showforcedupdates = true;
      status.aheadbehind = false;
      commitgraph.generationversion = 1;
      log.excludedecoration = "refs/prefetch/*";
      maintenance.auto = false;
      maintenance.strategy = "incremental";

      add.interactive.useBuiltin = false;
      delta = {
        navigate = true;
        light = false;
        side-by-side = true;
        line-numbers = true;
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";

      user.useConfigOnly = true;

      color = {
        status = "auto";
        diff = "auto";
        branch = "auto";
        interactive = "auto";
        grep = "auto";
      };

      pull.ff = "only";

      push.autoSetupRemote = true;

      gpg.format = "ssh";
    };

    aliases = {
      tree = "log --graph --all --format='%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s'";
      branches = ''
        !git branch -a --sort=authordate | cut -b 3- | sed "s/remotes\/origin\///" | sort | uniq | rg -v -- "->" | fzf | xargs git switch'';
      tags = "tag";
      stashes = "stash list";
      unstage = "reset -q HEAD --";
      discard = "checkout --";
      uncommit = "reset --mixed HEAD~";
      amend = "commit --amend";
      precommit = "diff --cached --diff-algorithm=minimal -w";
      remotes = "remote -v";
      delete-merged-branches = ''
        !git checkout -q main && \
          git for-each-ref refs/heads/ "--format=%(refname:short)" | \
          while read branch; do
            mergeBase=$(git merge-base main $branch) && \
              [[ $(git cherry main $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && \
              git branch -D $branch;
        done
      '';
    };

    ignores = [
      # direnv
      ".envrc"
      ".direnv"
      "local.nix"

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
