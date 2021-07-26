{ pkgs, ... }:

{
  imports =
    [ ./fish.nix ./tmux.nix ./alacritty.nix ./git.nix ./vim/default.nix ];

  programs.home-manager.enable = true;
  home.stateVersion = "21.03";

  home.packages = with pkgs; [
    alacritty # terminal emulator
    tig # git client
    starship # shell prompt
    ripgrep # replace from 'grep'
    fd # replace from 'find'
    procs # replace from ps
    ghq # remote repository management cli
    nkf
    navi
    killall
    httpie
    cargo-make
    gh

    # Nix
    manix
    any-nix-shell
    nixfmt # nix file formatter
    nix-prefetch-github

    # Kubernetes
    kubectl
    kubectx
    skaffold
    tilt
    kustomize
    kubernetes-helm
    kpt
    stern # multi pod and container log for Kubernetes
    kind # Kubernetes in Docker tool

    dive # explor docker layers
    google-cloud-sdk
    bazelisk
    conftest
    terraform
    sops
    buf
    shellcheck

    # Language

    ## Python
    python39

    ## Node.js
    nodejs
    yarn

    ## Rust
    rustup # The Rust toolchain installer
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

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.enable = true;
  xdg.configFile."tig/config".text = ''
    bind generic h scroll-left
    bind generic j move-down
    bind generic k move-up
    bind generic l scroll-right

    bind generic g  none
    bind generic gg move-first-line
    bind generic gj next
    bind generic gk previous
    bind generic gp parent
    bind generic gP back
    bind generic gn view-next

    bind main    G move-last-line
    bind generic G move-last-line
  '';

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
  };
}
