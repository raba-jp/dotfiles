#!/usr/bin/env bash

URL="https://nixos.org/nix/install"

# install using workaround for darwin systems
[[ $(uname -s) = "Darwin" ]] && FLAG="--darwin-use-unencrypted-nix-store-volume"
[[ ! -z "$1" ]] && URL="$1"

if command -v nix > /dev/null; then
    echo "nix is already installed on this system."
else
    bash <(curl -L $URL) --daemon $FLAG
    nix-env -iA nixpkgs.nix_2_4
fi
