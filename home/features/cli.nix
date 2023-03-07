{pkgs, ...}: {
  home = {
    sessionPath = ["$HOME/go/bin" "$HOME/.yarn/bin"];
    sessionVariables = {
      EDITOR = "hx";
      PAGER = "bat";
    };

    packages = with pkgs; [
      ripgrep
      fd
      tig
      procs
      ghq
      gh
      any-nix-shell
      nix-prefetch
      nix-prefetch-git
      deadnix
      statix
      rustup
      bitwarden-cli
      doppler
      shellcheck
      selene
      treefmt
      shfmt
      alejandra
      stylua
      gping
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
      cue
      bazelisk
      terraform
      terraformer
      terragrunt
      driftctl
      buf
      nodejs
      yarn
      aws-vault
      golangci-lint
      actionlint
      taplo
      rclone
      bun
      deno
      ecspresso
      tfmigrate
      colima
      pueue
      dotenv-linter
      gnumake
      tree-sitter
      gcc
      cargo-make
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    exa.enable = true;
    go.enable = true;
    jq.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    home-manager.enable = true;
  };
}
