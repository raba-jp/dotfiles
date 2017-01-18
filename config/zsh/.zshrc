##### anyenv #####
eval "$(anyenv init -)"

##### direnv #####
eval "$(direnv hook zsh)"

##### tmux plugin manager #####
if [ ! -d $XDG_CACHE_HOME/tmux/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $XDG_CACHE_HOME/tmux/tpm
fi

##### zplug #####
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

##### zshrc #####
zsh_file=(
  "01_alias.zsh"
  "02_options.zsh"
  "03_prompt.zsh"
  "04_functions.zsh"
  "05_autocomplate.zsh"
  "06_environment.zsh"
  "07_tmux.zsh"
  "08_peco.zsh"
)
for dir in ${zsh_file[@]}; do
  source $ZDOTDIR/$dir
done

##### enhancd #####
export ENHANCD_FILTER=peco
export ENHANCD_DIR=$XDG_CAHCE_HOME/zsh

##### zsh local config #####
[ -f $ZSH_CONF_DIR/.zshrc.local ] && source $ZSH_CONF_DIR/.zshrc.local
