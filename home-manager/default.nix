{ lib, pkgs, ... }: {
  imports = [
    # Terminal
    ./alacritty
    ./kitty
    # CLI
    ./bat
    ./direnv
    ./exa
    ./fish
    ./fzf
    ./git
    ./go
    ./jq
    ./starship
    ./tig
    ./tmux
    ./vim
    ./zoxide
    ./zsh
    ./dconf
    ./gtk
    ./hammerspoon
    ./wezterm
    ./sway
  ];

  nixpkgs.overlays = [ import ../overlays ];

  home = {
    sessionPath = [ "$GOPATH/bin" ];

    sessionVariables = {
      EDITOR = "vim";
      PAGER = "bat";
    };

    packages = with pkgs; [
      # CLI
      nkf
      killall
      gnupg
      git-crypt
      envsubst
      ripgrep # replace from 'grep'
      fd # replace from 'find'
      awscli2
      aws-vault
      graphviz
      watchman
      rs-git-fsmonitor
      lima
      yubikey-manager
      bitwarden-cli
      sops
      age
      ssh-to-age

      tig # git client
      lazygit
      procs # replace from ps
      ghq # remote repository management cli
      cargo-make
      gh
      gobang # TUI database management tool
      treefmt
      unzip

      # Nix
      cachix
      manix
      any-nix-shell
      nixpkgs-fmt
      nix-prefetch-github
      hci

      # Kubernetes
      kubectl
      kubectx
      skaffold
      tilt
      kustomize
      kubernetes-helm
      stern # multi pod and container log for Kubernetes
      kind # Kubernetes in Docker tool
      conftest

      dive # explor docker layers
      google-cloud-sdk
      bazelisk
      terraform
      terraformer
      terragrunt
      driftctl
      buf
      shellcheck
      shfmt

      # Language
      ## Go
      golangci-lint

      ## Node.js
      nodejs
      yarn

      ## Rust
      rustup # The Rust toolchain installer

      ## Lua
      stylua

      ## Elm
      elmPackages.elm
    ] ++ (if pkgs.stdenvNoCC.isLinux then [
      # CLI
      flutter
      kube3d
      xclip
      dconf2nix
      appimagekit
      appimage-run
      # GUI Apps
      google-chrome
      obsidian
      android-studio
      slack
      vscode
      # stack
      gnome3.dconf-editor
      via
      # Theme
      papirus-icon-theme
      nordic
      materia-theme
      papirus-icon-theme
      gnomeExtensions.pop-shell
      sidekick
      wezterm
      libnotify
      yubikey-personalization-gui
      gcc
    ] else [ ]);

    stateVersion = "21.11";
  };

  programs.home-manager.enable = true;
}
