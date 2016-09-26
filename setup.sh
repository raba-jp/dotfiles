#!/bin/sh
packages=(
"neovim/neovim/neovim"
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
)

mkdir ~/.config
mkdir ~/.cache
mkdir ~/.cache/dein

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  echo "$f"
done

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

for package in packages
do
  brew install $package
end

# zsh
# zplug install
zsh ~/dotfile/installer.zsh
ln -s ~/dotfile/config/zsh/themes/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
ln -s ~/dotfile/config/zsh/themes/pure/async.zsh /usr/local/share/zsh/site-functions/async

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

# Node.js
curl -L git.io/nodebrew | perl - setup
nodebrew install-binary 6.5.0
nodebrew use 6.5.0
