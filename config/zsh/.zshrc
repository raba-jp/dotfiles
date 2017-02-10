fpath=(
  $ZDOTDIR/functions
  $ZDOTDIR/completion
  $fpath
)

source $RBENV_ROOT/completions/rbenv.zsh
source $PYENV_ROOT/completions/pyenv.zsh
source $NODENV_ROOT/completions/nodenv.zsh

if [ ! -f $XDG_CONFIG_HOME/zsh/.zshrc.zwc -o $XDG_CONFIG_HOME/zsh/.zshrc -nt $XDG_CONFIG_HOME/zsh/.zshrc.zwc ]; then
   zcompile $XDG_CONFIG_HOME/zsh/.zshrc
fi

eval "$(direnv hook zsh)"
eval "$(fasd --init auto)"

##### plugins ######
source $ZPLUG_HOME/init.zsh
zplug "b4b4r07/zplug"
zplug "peco/peco", as:command, from:gh-r
zplug "mrowa44/emojify", as:command
zplug "stedolan/jq", from:gh-r, as:command
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "mollifier/anyframe"
zplug "b4b4r07/emoji-cli"
zplug "clvv/fasd", as:command, hook-build:"PREFIX=$HOME make install"
zplug load

##### alias #####
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

##### options #####
setopt no_beep
setopt print_eight_bit
HISTFILE=$XDG_CACHE_HOME/zsh/history
HISTSIZE=1000
SAVEHIST=1000
setopt auto_menu
bindkey -v

autoload -Uz do_enter
autoload -Uz history_selection
autoload -Uz path_selection
zle -N do_enter
zle -N history_selection
zle -N path_selection
bindkey '^m' do_enter
bindkey '^f' path_selection
bindkey '^h' anyframe-widget-execute-history

autoload -Uz docker_images_selection
autoload -Uz docker_container_selection
zle -N docker_images_selection
zle -N docker_container_selection
alias image_remove=docker_images_selection
alias container_stop=docker_container_selection

##### zsh local config #####
[ -f $ZSH_CONF_DIR/.zshrc.local ] && source $ZSH_CONF_DIR/.zshrc.local

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
