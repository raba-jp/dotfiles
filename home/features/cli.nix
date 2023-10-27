{
  outputs,
  pkgs,
  ...
}: {
  home = {
    sessionPath = ["$HOME/go/bin" "$HOME/.yarn/bin"];
    sessionVariables = {
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
      outputs.packages.${pkgs.system}.devenv
      nil
      gobang
      # LSP
      buf-language-server
      clojure-lsp
      solargraph
      gopls
      terraform-ls
      efm-langserver
      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.graphql-language-service-cli
      jsonnet-language-server
      nil
      walk
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza.enable = true;
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
