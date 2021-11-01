{ pkgs, stable, ... }:

{
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
    clang-tools
    yq
    envsubst
    zstd

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
    # luaformatter

    ## Elm
    elmPackages.elm

    ## Java
    adoptopenjdk-openj9-bin-11

    ## OpenAPI
    openapi-generator-cli
  ];
}
