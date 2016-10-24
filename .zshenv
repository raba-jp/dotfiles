##### zplug #####
export ZPLUG_HOME=/usr/local/opt/zplug

##### XDG BASE DIRECTORY #####
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

##### Editor Path #####
export ATOM_HOME=$XDG_DATA_HOME/atom

#### #Common Path #####
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE=$XDG_CACHE_HOME/zsh/history

##### npm Path #####
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

##### Language Path #####
export GOPATH=$HOME/Sources
export ANYENV=$HOME/.anyenv/bin

##### Path #####
path=(
  $GOPATH(N-/)
  $ANYENV(N-/)
  $path
)
