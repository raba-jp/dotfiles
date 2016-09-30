##### XDG BASE DIRECTORY #####
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share

##### Editor Path #####
ATOM_HOME=$XDG_DATA_HOME/atom
VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
VIMDOTDIR="$XDG_CONFIG_HOME/vim"

#### #Common Path #####
LESSHISTFILE=$XDG_CACHE_HOME/less/history
MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
ZDOTDIR=$XDG_CONFIG_HOME/zsh
HISTFILE=$XDG_CACHE_HOME/zsh/history

##### npm Path #####
NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

##### Language Path #####
GOPATH=$HOME/go
RBPATH=$HOME/.rbenv/bin
PYPATH=$HOME/.pyenv/bin
NDPATH=$HOME/.nodebrew/current/bin


##### Path #####
path=(
  $GOPATH(N-/)
  $RBPATH(N-/)
  $PYPATH(N-/)
  $NDPATH(N-/)
  $path
)
