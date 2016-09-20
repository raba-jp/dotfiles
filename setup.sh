#!/bin/sh
mkdir ~/.config
mkdir ~/.cache

# Homebrew
if ! which brew >& /dev/null;then
  brew_installed=0
  echo Homebrew is not installed!
  echo Install now...
  echo ruby -e \"\$\(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install\)\"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo
fi

# CLI install
brew install neovim/neovim/neovim
brew install rbenv
brew install pyenv
brew install zsh
brew install tmux
brew install go
brew install glide
brew install ghq
brew install peco

# Git
ln -s ~/dotfile/git/.gitconfig

# NeoVim
mkdir ~/.cache/dein
ln -s ~/dotfile/nvim ~/.config/nvim

# tmux
ln -s ~/dotfile/tmux/.tmux.conf .tmux.conf

# zsh
# zplug install
zsh ~/dotfile/installer.zsh
ln -s ~/dotfile/zsh/.zshrc ~/.zshrc

# Ruby
rbenv install 2.3.1
rbenv rehash
rbenv global 2.3.1
gem install bundler
gem install rubocop

# Node.js
curl -L git.io/nodebrew | perl - setup
nodebrew install-binary 6.5.0
nodebrew use 6.5.0
