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

rbenv install 2.3.1
rbenv rehash
rbenv global 2.3.1
gem install bundler
gem install rubocop
