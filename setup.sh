#!/bin/bash

set -e
set -u


setup_mac() {
	if [ "$(uname)" == 'Darwin' ]; then
		## Mac
		echo "Setup for Mac"
		which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		which ansible >/dev/null 2>&1 || brew install ansible
		which git >/dev/null 2>&1 || brew install git
	fi
}

setup_debian() {
	if   [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
		# Check Ubuntu or Debian
		if [ -e /etc/lsb-release ]; then
			# Ubuntu
			# Not implemented yet
			echo "Setup for Ubuntu"
			echo "Not implemented yet"
		else
			# Debian
			# Not implemented yet
			echo "Setup for Debian"
			echo "Not implemented yet"
		fi
	fi
}

setup_redhat() {
	if [ -e /etc/fedora-release ]; then
		# Fedra
		echo "Setup for Fedora"
		echo "Not implemented yet"
	elif [ -e /etc/redhat-release ]; then
		if [ -e /etc/oracle-release ]; then
			# Oracle Linux
			echo "Setup for Oracle Linux"
			echo "Not implemented yet"
		else
			# Red Hat Enterprise Linux
			echo "Setup for Red Hat Enterprise Linux"
			echo "Not implemented yet"
		fi
	fi
}

setup_arch() {
	if [ -e /etc/arch-release ]; then
		# Arch Linux
		echo "Setup for Arch Linux"
		echo "Not implemented yet"
	fi
}

setup_suse() {
	if [ -e /etc/SuSE-release ]; then
		# OpenSUSE
		echo "Setup for OpenSUSE"
		echo "Not implemented yet"
	fi
}

setup_mandriva() {
	if [ -e /etc/mandriva-release ]; then
		# Mandriva Linux
		echo "Setup for Mandriva Linux"
		echo "Not implemented yet"
	fi
}

setup_gentoo() {
	if [ -e /etc/gentoo-release ]; then
		# Gentoo Linux
		echo "Setup for Gentoo Linux"
		echo "Not implemented yet"
	fi
}

setup_common() {
	local dotfiles_dir=$HOME/.local/share/dotfiles
	if [ ! -e $dotfiles_dir ]; then
		git clone https://github.com/raba-jp/dotfiles $dotfiles_dir
	fi
	cd $dotfiles_dir
	ansible-playbook -i ansible/inventory ansible/main.yml
}

setup() {
	setup_mac
	setup_debian
	setup_redhat
	setup_arch
	setup_arch
	setup_suse
	setup_mandriva
	setup_gentoo
	setup_common
}

setup
