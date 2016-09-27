#!/bin/sh
DOT_DIR=~/dotfile

packages=(
  "caskroom/cask/brew-cask"
  "neovim/neovim/neovim"
  "reattach-to-user-namespace"
  "rbenv"
  "pyenv"
  "zsh"
  "tmux"
  "go"
  "glide"
  "ghq"
  "peco"
  "ctags"
  "the_silver_searcher"
  "curl"
  "wget"
  "docker"
  "docker-compose"
  "docker-machine"
)

cask_packages=(
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
)

mkdir ~/.config
mkdir ~/.cache
mkdir ~/.cache/dein

cd $DOT_DIR
for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  ln -snfv $DOT_DIR/$f $HOME/$f
done
cd $HOME

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

for package in ${packages[@]}
do
  brew install $package
done

for cask in ${cask_package[a]}
do
  brew cask install $cask
done

# zsh
# zplug install
zsh ~/dotfile/installer.zsh
zsh
zplug install
ln -s ~/.zplug/repos/sindresourhus/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
ln -s ~/.zplug/repos/sindresourhus/pure/async.zsh /usr/local/share/zsh/site-functions/async

# Ruby
rbenv install 2.3.1

# Python
pyenv install 3.5.2

# Node.js
curl -L git.io/nodebrew | perl - setup

