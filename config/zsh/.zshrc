if [ ! -f $XDG_CONFIG_HOME/zsh/.zshrc.zwc -o $XDG_CONFIG_HOME/zsh/.zshrc -nt $XDG_CONFIG_HOME/zsh/.zshrc.zwc ]; then
   zcompile $XDG_CONFIG_HOME/zsh/.zshrc
fi

if [ ! -d $XDG_CACHE_HOME/anyenv ]; then
  git clone https://github.com/riywo/anyenv $XDG_CACHE_HOME/anyenv
fi

if [ ! -d $XDG_CACHE_HOME/tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $XDG_CACHE_HOME/tmux/plugins/tpm
fi

source $ZPLUG_HOME/init.zsh
eval "$(anyenv init -)"
eval "$(direnv hook zsh)"

##### plugins ######
zplug "zsh-users/zsh-syntax-highlighting"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"
zplug "mrowa44/emojify", as:command
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme
zplug "zsh-users/zsh-autosuggestions"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

##### enhancd #####
export ENHANCD_FILTER=peco
export ENHANCD_DIR=$XDG_CACHE_HOME/zsh

##### alias #####
alias sudo='sudo '
alias ll='ls -alG'
alias untar='tar xzvf'
alias setlangja='export LANG=ja_JP.UTF-8'
alias setlangc='export LANG=C'
alias vim='nvim'
alias vi='nvim'

##### options #####
setopt no_beep
setopt print_eight_bit
HISTFILE=$XDG_CACHE_HOME/zsh/history
HISTSIZE=1000
SAVEHIST=1000
autoload -Uz compinit
compinit -u
setopt auto_menu
bindkey -v

function do_enter() {
  if [ -n "$BUFFER" ]; then
    zle accept-line
      return 0
  fi
  echo
  echo -e "\e[0;33m--- list files ---\e[0m"
    ls -alG
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
      echo
      echo -e "\e[0;33m--- git status ---\e[0m"
      git status --short --branch
      echo
    fi
    zle reset-prompt
    return 0
}

zle -N do_enter
bindkey '^m' do_enter

##### zsh local config #####
[ -f $ZSH_CONF_DIR/.zshrc.local ] && source $ZSH_CONF_DIR/.zshrc.local

##### Run tmux with my config #####
tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf
