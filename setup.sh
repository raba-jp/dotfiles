#!/bin/bash

set -e
set -u

setup() {
	local dotfiles_dir=$HOME/.local/share/dotfiles
	which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	which ansible >/dev/null 2>&1 || brew install ansible
	which git >/dev/null 2>&1 || brew install git
	if [ -e $dotfiles_dir ]; then
		git clone https://github.com/raba-jp/dotfiles $dotfiles_dir
	fi
	cd $dotfiles_dir
	ansible-playbook ansible/inventory ansible/main.yml
}

setup
