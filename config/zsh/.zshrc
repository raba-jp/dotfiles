source $ZPLUG_HOME/init.zsh
eval "$(anyenv init -)"
eval "$(direnv hook zsh)"

##### Tmux Plugin Manager #####
if [ ! -d $XDG_CACHE_HOME/tmux/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $XDG_CACHE_HOME/tmux/tpm
fi

##### plugins ######
zplug "zsh-users/zsh-syntax-highlighting"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"
zplug "mrowa44/emojify", as:command

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

##### enhancd #####
export ENHANCD_FILTER=peco
export ENHANCD_DIR=$XDG_CAHCE_HOME/zsh

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
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
autoload -Uz compinit
compinit -u
setopt auto_menu

source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/tmux.zsh

source $ZDOTDIR/completion/gcloud
##### zsh local config #####
[ -f $ZSH_CONF_DIR/.zshrc.local ] && source $ZSH_CONF_DIR/.zshrc.local
