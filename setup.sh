#!/bin/sh
DOTDIR=$HOME/dotfile
XDG_CACHE_HOME=$HOME/.cache
cd $DOTDIR

# Homebrew
if ! type brew > /dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

## Create Directory
dirs=(
  "~/.cache"
  "~/Development"
  "~/Development/src"
)

for dir in ${dirs[@]}; do
  if [ ! -d "$dir" ]; then
    echo "Create Directory -> $dir"
    mkdir $dir
  fi
done

## brew tap
brew_tap=(
  "caskroom/cask"
  "caskroom/fonts"
  "neovim/neovim"
)

for tap in ${brew_tap[@]}; do
  brew tap $tap
done

## brew install
brew_install=(
  "ctags"
  "curl"
  "direnv"
  "ghq"
  "git"
  "glide"
  "go"
  "neovim"
  "peco"
  "reattach-to-user-namespace"
  "tig"
  "tmux"
  "the_silver_searcher"
  "wget"
  "zsh"
  "zplug"
)

for brew in ${brew_install[@]}; do
  brew install $brew
done

## brew cask install
brew_cask_install=(
  "slack"
  "appcleaner"
  "quicklook-csv"
  "quicklook-json"
  "betterzipql"
  "the-unarchiver"
  "bathyscaphe"
  "qlmarkdown"
  "cheatsheet"
  "google-chrome"
  "google-drive"
  "dropbox"
  "bettertouchtool"
  "docker"
)

for brew in ${brew_cask_install[@]}; do
  brew cask install $brew
done

## dotfile init
ln -snvf $DOTDIR/.zshenv $HOME/.zshenv
ln -snvf $DOTDIR/config $HOME/.config

# anyenv
if [ ! -d $XDG_CACHE_HOME/anyenv ]; then
  git clone https://github.com/riywo/anyenv $XDG_CACHE_HOME/anyenv
fi

# Tmux Plugin Manager
if [ ! -d $XDG_CACHE_HOME/tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $XDG_CACHE_HOME/tmux/plugins/tpm
fi
