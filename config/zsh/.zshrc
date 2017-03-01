##############################
###          FPATH         ###
##############################
fpath=(
  $ZDOTDIR/functions
  $ZDOTDIR/completion
  $fpath
)

##############################
###      Auto compile      ###
##############################
if [ ! -f $XDG_CONFIG_HOME/zsh/.zshrc.zwc -o $XDG_CONFIG_HOME/zsh/.zshrc -nt $XDG_CONFIG_HOME/zsh/.zshrc.zwc ]; then
   zcompile $XDG_CONFIG_HOME/zsh/.zshrc
fi

##############################
###         Plugins        ###
##############################
source $ZPLUG_HOME/init.zsh
zplug load

##############################
###         Options        ###
##############################
setopt auto_menu
bindkey -v
setopt no_beep
setopt print_eight_bit

### History ###
HISTFILE=$XDG_CACHE_HOME/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

##############################
###        Auto load       ###
##############################
autoload -Uz do_enter
autoload -Uz history_selection
autoload -Uz path_selection
autoload -Uz docker_images_selection
autoload -Uz docker_container_selection
autoload -Uz git_cd
zle -N do_enter
zle -N history_selection
zle -N path_selection
zle -N docker_images_selection
zle -N docker_container_selection
zle -N git_cd

##############################
###       Key binding      ###
##############################
bindkey '^m' do_enter
bindkey '^f' path_selection
bindkey '^h' anyframe-widget-execute-history

##############################
###          Alias         ###
##############################
alias sudo='sudo '
alias ll='ls -alG'
alias untar='tar xzvf'
alias setlangja='export LANG=ja_JP.UTF-8'
alias setlangc='export LANG=C'
alias vim='nvim'
alias vi='nvim'
alias kill=anyframe-widget-kill
alias ghq=anyframe-widget-cd-ghq-repository
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias image_remove=docker_images_selection
alias container_stop=docker_container_selection
alias up='cd ../'
alias down'cd -d */ \
	| anyframe-selector-auto \
	anyframe-action-execute cd'
alias cd=git_cd

##############################
###    Settings loading    ###
##############################
case $OSTYPE in
  darwin*)
    [ -f $ZSH_CONF_DIR/osx.zsh ] && source $ZSH_CONF_DIR/osx.zsh
    ;;
  linux*)
    [ -f $ZSH_CONF_DIR/linux.zsh ] && source $ZSH_CONF_DIR/linux.zsh
    ;;
esac

[ -f $ZSH_CONF_DIR/.zshrc.local ] && source $ZSH_CONF_DIR/.zshrc.local

##############################
###          env           ###
##############################
source $RBENV_ROOT/completions/rbenv.zsh
source $PYENV_ROOT/completions/pyenv.zsh
source $NODENV_ROOT/completions/nodenv.zsh

export PATH=$RBENV_ROOT/shims:$PYENV_ROOT/shims:$NODENV_ROOT/shims:$PATH

rbenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}

pyenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}

nodenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(nodenv "sh-$command" "$@")";;
  *)
    command nodenv "$command" "$@";;
  esac
}
