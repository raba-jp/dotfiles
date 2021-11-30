{ pkgs, stable, ... }:

{
  home.packages = with pkgs; [
    # Termianl emulator
    alacritty
    kitty

    # CLI
    nkf
    killall
    gnupg
    git-crypt
    envsubst
    starship # shell prompt
    ripgrep # replace from 'grep'
    fd # replace from 'find'

    tig # git client
    procs # replace from ps
    ghq # remote repository management cli
    navi
    httpie
    cargo-make
    gh
    yq
    gobang # TUI database management tool

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
    stern # multi pod and container log for Kubernetes
    kind # Kubernetes in Docker tool
    conftest

    dive # explor docker layers
    google-cloud-sdk
    bazelisk
    terraform
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
    poetry

    ## Node.js
    nodejs
    yarn

    ## Rust
    rustup # The Rust toolchain installer

    ## Lua
    luaformatter

    ## Elm
    elmPackages.elm
  ];
}
