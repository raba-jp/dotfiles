#!/bin/bash

set -e
set -u

setup() {
	local dotfiles_dir=$HOME/.local/share/dotfiles
	which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install ansible
	brew install git
	git clone https://github.com/raba-jp/dotfiles $dotfiles_dir
	cd $dotfiles_dir
	ansible-playbook ansible/inventory ansible/main.yml
}

setup
