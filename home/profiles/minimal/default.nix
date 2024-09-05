{
  pkgs,
  inputs,
  ...
}: {
  home = {
    sessionVariables = {
      PAGER = "bat";
    };

    packages = with pkgs; [
      ripgrep
      gh
    ];
  };

  programs.eza.enable = true;
  programs.home-manager.enable = true;

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };

  programs.bat = {
    enable = true;
    config.style = "changes,header";
    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = ["--preview 'exa --tree {} | head -200'"];
    defaultCommand = "fd --type f";
    fileWidgetOptions = [
      "--preview 'bat  --color=always --style=header,grid --line-range=:300 {}'"
    ];
    colors = {
      "bg" = "#1e1e2e";
      "bg+" = "#313244";
      "spinner" = "#f5e0dc";
      "hl" = "#f38ba8";
      "fg" = "#cdd6f4";
      "header" = "#f38ba8";
      "info" = "#cba6f7";
      "pointer" = "#f5e0dc";
      "marker" = "#f5e0dc";
      "fg+" = "#cdd6f4";
      "prompt" = "#cba6f7";
      "hl+" = "#f38ba8";
    };
  };

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
    '';

    shellAliases = {
      ls = "eza";
      ll = "eza --all --long --grid --header --no-filesize --no-time --no-user --git --icons";
      tree = "eza --tree --icons --all --git-ignore --ignore-glob=.git";
      cat = "bat";
    };

    shellAbbrs = {
      grep = "rg";
      untar = "tar -xvf";
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

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
