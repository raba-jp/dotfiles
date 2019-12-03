#!/bin/bash

set -e

cd `dirname $0`

type ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
  if [ "$(uname)" = 'Darwin' ]; then
    # Mac
    echo "Setup for Mac"
    echo "Install homebrew"
    which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null 2>&1
    echo "brew install ansible"
    which ansible >/dev/null 2>&1 || brew install ansible > /dev/null 2>&1
    echo "Setup done"
  fi

  if   [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    # Ubuntu
    # Not implemented yet
    echo "Setup for Ubuntu"
    echo "sudo apt update"
    sudo apt update > /dev/null 2>&1
    echo "sudo apt install software-properties-common"
    sudo apt install software-properties-common > /dev/null 2>&1
    echo "sudo apt-add-repository ppa:ansible/ansible"
    sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1
    echo "sudo apt update"
    sudo apt update > /dev/null 2>&1
    echo "sudo apt install ansible"
    sudo apt install ansible > /dev/null 2>&1
    echo "Setup done"
  fi

fi
## べき等にする
## if [ -e /etc/arch-release ]; then
##   # Arch Linux
##   mkdir -p ~/.ansible/plugins/modules
##   git clone https://github.com/kewlfft/ansible-aur.git ~/.ansible/plugins/modules/aur
## fi

if [ $# -eq 1 ]; then
  ansible-playbook -i inventory main.yml --ask-become-pass --tags $1
else
  ansible-playbook -i inventory main.yml --ask-become-pass
fi
