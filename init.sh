#!/bin/sh

set -e


if [ "$(uname)" = 'Darwin' ]; then
  sh <(wget -q -O - https://nixos.org/nix/install) --daemon
  echo 'export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH' >> ~/.zshrc
fi

nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

dir=$HOME/ghq/github.com/raba-jp
dotfiles=$dir/dotfiles
if [ "$1" != '' ]; then
  dotfiles=$1
fi

if [ ! -d $dotfiles ]; then
  mkdir -p $dir	
  git clone https://github.com/raba-jp/dotfiles.git $dotfiles
fi
