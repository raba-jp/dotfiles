#!/bin/bash

set -e

if [ "$(uname)" == 'Darwin' ]; then
  # Mac
  echo "Setup for Mac"
  which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null 2>&1
  which ansible >/dev/null 2>&1 || brew install ansible > /dev/null 2>&1
  which git >/dev/null 2>&1 || brew install git > /dev/null 2>&1
  echo "Setup done"
fi

if   [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
  # Ubuntu
  # Not implemented yet
  echo "Setup for Ubuntu"
  sudo apt update > /dev/null 2>&1
  sudo apt install software-properties-common > /dev/null 2>&1
  sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1
  sudo apt update > /dev/null 2>&1
  sudo apt install ansible > /dev/null 2>&1
  echo "Setup done"
fi

dotfiles_dir=$HOME/.local/share/dotfiles
if [ ! -e $dotfiles_dir ]; then
  git clone https://github.com/raba-jp/dotfiles $dotfiles_dir
fi
cd $dotfiles_dir
if [ $# -eq 1 ]; then
  ansible-playbook -i ansible/inventory ansible/main.yml --tags $1
else
  ansible-playbook -i ansible/inventory ansible/main.yml
fi
