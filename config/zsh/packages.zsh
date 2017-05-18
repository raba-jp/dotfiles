zplug "mafredri/zsh-async", use:async.zsh
zplug "sindresorhus/pure", use:pure.zsh, as:theme
zplug "zsh-users/zsh-completions", lazy:true
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", lazy:true
zplug "marzocchi/zsh-notify"
zplug "mollifier/anyframe"
zplug "rabafea/ot", as:command, use:'(*).sh', rename-to:'$1'
