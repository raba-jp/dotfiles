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
)

cask_packages=(
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

# zsh
# zplug install
zsh ~/dotfile/installer.zsh
zsh
zplug install
ln -s ~/.zplug/repos/sindresourhus/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
ln -s ~/.zplug/repos/sindresourhus/pure/async.zsh /usr/local/share/zsh/site-functions/async

# Ruby
rbenv install 2.3.1
rbenv rehash
rbenv global 2.3.1
gem install bundler
gem install rubocop

# Python
pyenv install 3.5.2
pyenv rehash
pyenv global 3.5.2
pip install neovim

# Node.js
curl -L git.io/nodebrew | perl - setup
nodebrew install-binary 6.5.0
nodebrew use 6.5.0

