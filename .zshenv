##### zplug #####
export ZPLUG_HOME=/usr/local/opt/zplug

##### XDG BASE DIRECTORY #####
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

##### Editor Path #####
export ATOM_HOME=$XDG_DATA_HOME/atom
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc.vim" | source $MYVIMRC'
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"

#### #Common Path #####
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE=$XDG_CACHE_HOME/zsh/history

##### npm Path #####
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

##### Language Path #####
export GOPATH=$HOME/go
export RBPATH=$HOME/.rbenv/bin
export PYPATH=$HOME/.pyenv/bin
export NDPATH=$HOME/.nodebrew/current/bin


##### Path #####
path=(
  $GOPATH(N-/)
  $RBPATH(N-/)
  $PYPATH(N-/)
  $NDPATH(N-/)
  $path
)
