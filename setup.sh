#!/bin/sh
mkdir ~/.config
mkdir ~/.cache

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
"
# NeoVim
mkdir ~/.cache/dein
ln -s ~/dotfile/nvim ~/.config/nvim

# tmux
ln -s ~/dotfile/tmux/.tmux.conf .tmux.conf

# zsh
# zplug install
zsh ~/dotfile/installer.zsh
ln -s ~/dotfile/zsh/.zshrc ~/.zshrc
