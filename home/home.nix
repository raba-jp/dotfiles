{ pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./xdg.nix
    ./fish.nix
    ./tmux.nix
    ./alacritty.nix
    ./git.nix
    ./vim/default.nix
  ];

  home.stateVersion = "21.03";

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
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
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
      enableFishIntegration = true;
    };

    broot = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
