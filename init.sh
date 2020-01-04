#!/bin/sh
set -e

if [ "$(uname)" = 'Darwin' ]; then
	xcode-select --install
	which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ ! -d $HOME/dotfiles ]; then
	git clone https://github.com/raba-jp/dotfiles.git $HOME/dotfiles
fi

$HOME/dotfiles/install.sh
