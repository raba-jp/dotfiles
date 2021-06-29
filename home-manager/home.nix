{ pkgs, ... }:

{
  imports = [ ./fish.nix ./tmux.nix ./alacritty.nix ./git.nix ];

  programs.home-manager.enable = true;
  home.username = "sakuraba";
  home.homeDirectory = "/home/sakuraba";
  home.stateVersion = "21.03";

  home.packages = with pkgs; [
    alacritty
    google-chrome
    git
    arc-theme
    materia-theme
    gitAndTools.tig
    starship
    fish
    obsidian
    vim
    ripgrep
    fd
    procs
    ghq
    fzf
    nixfmt
    vscode
    tmux
  ];

  programs.exa.enable = true;
  programs.jq.enable = true;
  programs.go.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "Solarized (dark)";
      style = "changes,header";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
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

  programs.vscode = { enable = true; };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.enable = true;

  # gtk.theme = {
  # name = "Arc Darker"
  # };

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
  };

}
