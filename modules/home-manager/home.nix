{ pkgs, ... }: {
  home = {
    sessionPath = [ "$GOPATH/bin" ];

    sessionVariables = { EDITOR = "vim"; };

    stateVersion = "21.11";
  };

  programs = {
    home-manager.enable = true;

    exa.enable = true;

    jq.enable = true;

    go = {
      enable = true;
      goPath = "go";
    };

    bat = {
      enable = true;
      config = {
        theme = "Nord";
        style = "changes,header";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      changeDirWidgetCommand = "fd --type d";
      changeDirWidgetOptions = [ "--preview 'exa --tree {} | head -200'" ];
      defaultCommand = "fd --type f";
      fileWidgetOptions = [
        "--preview 'bat  --color=always --style=header,grid --line-range=:300 {}'"
      ];
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [ "-w 80%" "-h 50%" ];
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    broot = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}
