#!/bin/bash
DOTDIR=$HOME/dotfile
XDG_CACHE_HOME=$HOME/.cache

DIRECTORIES=$DOTDIR/setup/directories.txt
BREW_TAP_FILE=$DOTDIR/setup/brew_tap.txt
BREW_FILE=$DOTDIR/setup/brew.txt
BREW_CASK_FILE=$DOTDIR/setup/brew_cask.txt

RUBY_VERSION=2.4.0
PYTHON_VERSION=3.6.0

if [ -n `echo $OSTYPE | grep "darwin"` ]; then
  echo "OS type: MacOS"

  if ! type brew > /dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  cat $DIRECTORIES | while read line; do
    if [ ! -d "$line" ]; then
      mkdir -p $line
    fi
  done

  cat $BREW_TAP_FILE | while read line; do
    brew tap $line
  done

  cat $BREW_FILE | while read line; do
    if [ -z `brew list | grep $line` ]; then
      brew install $line
    fi
  done

  cat $BREW_CASK_FILE | while read line; do
    if [ -z `brew cask list | grep $line` ]; then
      brew cask install $line
    fi
  done
fi

if [ ! -d $XDG_CACHE_HOME/rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git $XDG_CACHE_HOME/rbenv
  git clone https://github.com/rbenv/ruby-build.git $XDG_CACHE_HOME/rbenv/plugins/ruby-build
  rbenv install $RUBY_VERSION
  rbenv rehash
  rbenv global $RUBY_VERSION
fi

if [ ! -d $XDG_CACHE_HOME/pyenv ]; then
  git clone https://github.com/yyuu/pyenv.git $XDG_CACHE_HOME/pyenv
  pyenv install $PYTHON_VERSION
  pyenv rehash
  pyenv global $PYTHON_VERSION
fi

if [ ! -d $XDG_CACHE_HOME/nodenv ]; then
  git clone https://github.com/nodenv/nodenv.git $XDG_CACHE_HOME/nodenv
  git clone https://github.com/nodenv/node-build.git $XDG_CACHE_HOME/nodenv/plugins/node-build
fi

if [ ! -d $XDG_CACHE_HOME/tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $XDG_CACHE_HOME/tmux/plugins/tpm
fi

if [ ! -d $XDG_CACHE_HOME/zsh/zplug ]; then
  git clone https://github.com/b4b4r07/zplug $XDG_CACHE_HOME/zsh/zplug
fi
