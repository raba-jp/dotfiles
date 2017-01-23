#!/bin/sh
DOTDIR=$HOME/dotfile

cd $DOTDIR

if ! type brew >/dev/null 2>&1
then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

## Create Directory
dirs=(
  "~/.cache"
  "~/Development"
  "~/Development/src"
)

for dir in ${dirs[@]}
do
  if [ ! -e "$dir" ]
    then
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

for brew in ${brew_tap[@]}
do
  brew tap $brew 
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

for brew in ${brew_install[@]}
do
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

for brew in ${brew_cask_install[@]}
do
  brew cask install $brew
done

## dotfile init
if [-e '~/.zshenv' ]
then
  ln -s $DOTDIR/.zshenv ~/.zshenv
  ln -s $DOTDIR/config ~/.config
fi

git clone https://github.com/riywo/anyenv ~/.anyenv
