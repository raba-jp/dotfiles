{ pkgs, stable, ... }:

{
  home.packages = with pkgs; [
    # Termianl emulator
    kitty
    # alacritty

    # CLI
    nkf
    killall
    gnupg
    gnused
    git-crypt
    envsubst
    starship # shell prompt
    ripgrep # replace from 'grep'
    fd # replace from 'find'
    awscli2
    graphviz

    tig # git client
    lazygit
    procs # replace from ps
    ghq # remote repository management cli
    navi
    httpie
    cargo-make
    gh
    yq
    gobang # TUI database management tool
    treefmt
    unzip
    lima
    watchman
    rs-git-fsmonitor

    # Nix
    cachix
    manix
    any-nix-shell
    nixpkgs-fmt
    nix-prefetch-github

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
    driftctl
    buf
    shellcheck
    shfmt

    # Language
    ## Go
    golangci-lint

    ## Python
    python39
    python39Packages.pip
    python39Packages.setuptools
    python39Packages.black
    poetry

    ## Node.js
    nodejs
    yarn

    ## Rust
    rustup # The Rust toolchain installer

    ## Lua
    stylua

    ## Elm
    elmPackages.elm
  ];
}
