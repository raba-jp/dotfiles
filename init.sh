#!/bin/sh
set -e

if [ "$(uname)" = 'Darwin' ]; then
	xcode-select --install
	which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ -e /etc/arch-release ]; then
	if [ "$(cat /etc/arch-release)" = 'Manjaro Linux' ]; then
		# Manjaro Linux
		pacman -Sy --noconfirm yay
	else
		# Arch Linux
		yay_version=9.4.2
		curl -Lo yay.tar.gz https://github.com/Jguer/yay/releases/download/v${yay_version}/yay_${yay_version}_x86_64.tar.gz
		tar xvf yay.tar.gz
		sudo mv yay_${yay_version}_x86_64/yay /usr/local/bin/yay
		rm -rf yay yay.tar.gz
	fi

fi


dotfiles=$HOME/dotfiles
if [ "$1" != '' ]; then
	dotfiles=$1
fi

if [ ! -d $dotfiles ]; then
	git clone https://github.com/raba-jp/dotfiles.git $dotfiles
fi

$dotfiles/install.sh
