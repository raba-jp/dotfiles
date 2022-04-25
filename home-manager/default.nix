{ lib, pkgs, ... }: {
  imports = [
    ./fish
    ./fzf
    ./git
    ./starship
    ./tig
    ./vim
    ./wezterm
    ./dconf
    ./gtk
    ./hammerspoon
    ./sway
  ];

  home = {
    stateVersion = "21.11";

    sessionPath = [ "$GOPATH/bin" ];

    sessionVariables = {
      EDITOR = "vim";
      PAGER = "bat";
    };

    packages = with pkgs; [
      unzip
      nkf
      killall
      gnupg
      envsubst
      ripgrep
      fd
      watchman
      rs-git-fsmonitor
      tig
      lazygit
      procs
      ghq
      gh
      google-cloud-sdk
      bazelisk
      terraform
      terraformer
      terragrunt
      driftctl
      buf
      any-nix-shell
      cachix
      nix-prefetch-github
      nodejs
      yarn
      rustup
      awscli2
      aws-vault
      yubikey-manager
      bitwarden-cli
      sops
      age
      ssh-to-age

      # Kubernetes
      kubectl
      kubectx
      skaffold
      tilt
      kustomize
      kubernetes-helm
      stern
      kind
      conftest
      dive

      # Linter
      golangci-lint
      shellcheck

      # Formatter
      treefmt
      shfmt
      nixpkgs-fmt
      stylua
    ] ++ (if stdenvNoCC.isLinux then [
      flutter
      kube3d
      xclip
      dconf2nix
      libnotify
      yubikey-personalization-gui
      gcc
      wezterm
    ] else [ ]);
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "Nord";
        style = "changes,header";
      };
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    go = {
      enable = true;
      goPath = "go";
    };

    jq.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}
