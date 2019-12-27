#!/bin/bash

set -e

setup_darwin() {
  if [ "$(uname)" = 'Darwin' ]; then
    # Mac
    echo "Setup for Mac"
    echo "Install homebrew"
    which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "brew install ansible"
    which ansible >/dev/null 2>&1 || brew install ansible > /dev/null 2>&1
  fi
}

setup_arch() {
 if [ -e /etc/arch-release ]; then
   if [ ! -e ~/.ansible/plugins/modules/aur ]; then
     mkdir -p ~/.ansible/plugins/modules
     git clone https://github.com/kewlfft/ansible-aur.git ~/.ansible/plugins/modules/aur
   fi
   pacman -S ansible
 fi
}

cd `dirname $0`

type ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
  setup_darwin
  setup_arch
fi

if [ $# -eq 1 ]; then
  ansible-playbook -i inventory main.yml --ask-become-pass --tags $1
else
  ansible-playbook -i inventory main.yml --ask-become-pass
fi
