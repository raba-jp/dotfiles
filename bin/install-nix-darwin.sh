#!/usr/bin/env bash

NIX_DARWIN_URL="https://github.com/LnL7/nix-darwin/archive/master.tar.gz"

nix-build $NIX_DARWIN_URL -A installer
./result/bin/darwin-installer
