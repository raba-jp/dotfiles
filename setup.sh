#!/bin/sh
DOTDIR=$HOME/dotfile

cd $DOTDIR

if ! type brew
then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

## Create Directory
dirs=(
  "~/.cache"
  "~/.cache/vim"
  "~/.cache/vim/dein"
  "~/.cache/zsh"
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
  "neovim/neovim"
)

for brew in ${brew_tap[@]}
do
  brew tap $brew 
done

## brew install
brew_install=(
  "brew-cask"
  "ctags"
  "curl"
  "docker"
  "docker-compose"
  "docker-machine"
  "ghq"
  "git"
  "glide"
  "go"
  "neovim"
  "peco"
  "reattach-to-user-namespace"
  "tmux"
  "the_silver_searcher"
  "vim --with-lua --with-luajit --with-python3"
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
  "virtualbox"
  "appcleaner"
  "quicklook-csv"
  "quicklook-json"
  "betterzipql"
  "the-unarchiver"
  "bathyscaphe"
  "sourcetree"
  "qlmarkdown"
  "cheatsheet"
  "google-chrome"
  "google-drive"
  "dropbox"
)

for brew in ${brew_cask_install[@]}
do
  brew cask install $brew
done

## dotfile init
if [-e '~/.zshenv' ]
then
  mv $HOME/.zshenv $HOME/.zshenv.bk
  ln -s $DOTDIR/.zshenv $HOME/.zshenv
  ln -s $DOTDIR/config $HOME/.config
fi

git clone https://github.com/riywo/anyenv ~/.anyenv
exec $SHELL -l 

anyenv install pyenv
anyenv install rbenv
anyenv install ndenv
