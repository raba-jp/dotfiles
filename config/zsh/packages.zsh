zplug "b4b4r07/zplug"

zplug "peco/peco", \
  as:command, \
  from:gh-r, \
  lazy:true

zplug "mrowa44/emojify", \
  as:command

zplug "stedolan/jq", \
  as:command, \
  from:gh-r, \
  lazy:true

zplug "sindresorhus/pure", \
  use:pure.zsh, \
  as:theme

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-syntax-highlighting", \
  defer:2

zplug "zsh-users/zsh-autosuggestions"

zplug "mollifier/anyframe"

zplug "b4b4r07/emoji-cli"

zplug "clvv/fasd", \
  as:command, \
  hook-build:"PREFIX=$HOME make install", \
  hook-load:"eval $(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install)"

zplug "marzocchi/zsh-notify"
