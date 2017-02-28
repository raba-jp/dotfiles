#!/bin/bash
DOTDIR=$HOME/dotfile
XDG_CACHE_HOME=$HOME/.cache

DIRECTORIES=$DOTDIR/setup/directories.txt
BREW_TAP_FILE=$DOTDIR/setup/brew_tap.txt
BREW_FILE=$DOTDIR/setup/brew.txt
BREW_CASK_FILE=$DOTDIR/setup/brew_cask.txt

RUBY_VERSION=2.4.0
PYTHON2_VERSION=2.7.13
PYTHON3_VERSION=3.6.0

if [ -n `echo $OSTYPE | grep "darwin"` ]; then
  echo "OS type: MacOS"

  if ! type brew > /dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 1>/dev/null
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
      brew install $line 1>/dev/null
    fi
  done

  cat $BREW_CASK_FILE | while read line; do
    if [ -z `brew cask list | grep $line` ]; then
      brew cask install $line 1>/dev/null
    fi
  done
fi

if [ ! -d $XDG_CACHE_HOME/rbenv ]; then
  echo "rbenv setup"
  git clone https://github.com/rbenv/rbenv.git $XDG_CACHE_HOME/rbenv 1>/dev/null
  git clone https://github.com/rbenv/ruby-build.git $XDG_CACHE_HOME/rbenv/plugins/ruby-build 1>/dev/null
  echo "Ruby $RUBY_VERSION install"
  rbenv install $RUBY_VERSION 1>/dev/null
  rbenv global $RUBY_VERSION
  rbenv rehash

  gem install neovim
fi

if [ ! -d $XDG_CACHE_HOME/pyenv ]; then
  echo "pyenv setup"
  git clone https://github.com/yyuu/pyenv.git $XDG_CACHE_HOME/pyenv 1>/dev/null
  echo "Python $PYTHON2_VERSION install"
  pyenv install $PYTHON2_VERSION 1>/dev/null
  echo "Python $PYTHON3_VERSION install"
  pyenv install $PYTHON3_VERSION 1>/dev/null
  pyenv global $PYTHON2_VERSION $PYTHON3_VERSION
  pyenv rehash

  pip install neovim 1>/dev/null
  pip3 install neovim 1>/dev/null
fi

if [ ! -d $XDG_CACHE_HOME/nodenv ]; then
  echo "nodenv setup"
  git clone https://github.com/nodenv/nodenv.git $XDG_CACHE_HOME/nodenv 1>/dev/null
  git clone https://github.com/nodenv/node-build.git $XDG_CACHE_HOME/nodenv/plugins/node-build 1>/dev/null
fi

if [ ! -d $XDG_CACHE_HOME/tmux/plugins/tpm ]; then
  echo "tpm setup"
  git clone https://github.com/tmux-plugins/tpm $XDG_CACHE_HOME/tmux/plugins/tpm 1>/dev/null
fi

if [ ! -d $XDG_CACHE_HOME/zsh/zplug ]; then
  echo "zplug setup"
  git clone https://github.com/b4b4r07/zplug $XDG_DATA_HOME/zplug 1>/dev/null
fi
