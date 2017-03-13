zplug "b4b4r07/zplug", \
  hook-build:'zplug --self-manage'

zplug "peco/peco", \
  as:command, \
  from:gh-r, \
  lazy:true

zplug "mrowa44/emojify", \
  as:command, \
  lazy:true

zplug "stedolan/jq", \
  as:command, \
  from:gh-r, \
  lazy:true

zplug "motemen/ghq", \
  as:command, \
  from:gh-r, \
  lazy:true

zplug "clvv/fasd", \
  as:command, \
  hook-build:"PREFIX=$HOME make install", \
  hook-load:"eval $(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install)", \
  lazy:true

zplug "mafredri/zsh-async", \
  use:async.zsh

zplug "sindresorhus/pure", \
  use:pure.zsh, \
  as:theme

zplug "zsh-users/zsh-completions", \
  lazy:true

zplug "zsh-users/zsh-syntax-highlighting", \
  defer:2

zplug "zsh-users/zsh-autosuggestions", \
  lazy:true

zplug "mollifier/anyframe"

zplug "marzocchi/zsh-notify", \
  lazy:true

zplug "b4b4r07/zsh-history", \
  defer:3, \
  use:init.zsh

if zplug check 'b4b4r07/zsh-history'; then
    export ZSH_HISTORY_FILE="$XDG_CACHE_HOME/zsh/history.db"
    ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
    ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
    ZSH_HISTORY_KEYBIND_SCREEN="^r^r"
    ZSH_HISTORY_KEYBIND_ARROW_UP="^p"
    ZSH_HISTORY_KEYBIND_ARROW_DOWN="^n"
fi
