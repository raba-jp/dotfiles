source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "b4b4r07/enhancd"
zplug "zsh-users/zsh-completions"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

ZSH_CONF_DIR=$XDG_CONFIG_HOME/zsh
zplug "$ZSH_CONF_DIR/options", from:local

zplug load --verbose

export ENHANCD_FILTER=peco
source $ZPLUG_HOME/repos/b4b4r07/enhancd/init.sh
