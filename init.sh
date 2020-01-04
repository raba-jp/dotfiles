#!/bin/sh
set -e

if [ "$(uname)" = 'Darwin' ]; then
	xcode-select --install
	which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

dotfiles=$HOME/dotfiles

if [ "$1" != '' ]; then
	dotfiles=$1
fi

if [ ! -d $dotfiles ]; then
	git clone https://github.com/raba-jp/dotfiles.git $dotfiles
fi

$dotfiles/install.sh
