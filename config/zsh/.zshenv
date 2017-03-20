zmodload zsh/zprof && zprof
if [ -z $ZSHEMV_LOADED ]; then
  ##### XDG BASE DIRECTORY #####
  export XDG_CONFIG_HOME=$HOME/.config
  export XDG_CACHE_HOME=$HOME/.cache
  export XDG_DATA_HOME=$HOME/.local/share

  ##### zplug #####
  export ZPLUG_HOME=$XDG_DATA_HOME/zplug
  export ZPLUG_LOADFILE=$XDG_CONFIG_HOME/zsh/packages.zsh
  export ZPLUG_USE_CACHE=true
  export ZPLUG_CACHE_DIR=$XDG_CACHE_HOME/zplug

  ##### Editor Path #####
  export ATOM_HOME=$XDG_DATA_HOME/atom

  #### #Common Path #####
  export LESSHISTFILE=$XDG_CACHE_HOME/less/history
  export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
  export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
  export ZDOTDIR=$XDG_CONFIG_HOME/zsh
  export EDITOR=nvim

  ##### Go #####
  export GOPATH=$HOME/Development

  ##### Goolge App Engine SDK #####
  export GAEPATH=$HOME/GoogleAppEngine
  export GAE_GOPATH=$GAEPATH/go_appengine

  ##### Google Cloud SDK #####
  export GCPPATH=$HOME/google-cloud-sdk

  ##### Android SDK #####
  export ANDROID_SDK_TOOLS=$HOME/Library/Android/sdk/tools
  export ANDROID_SDK_PLATFORM_TOOLS=$HOME/Library/Android/sdk/platform-tools

  export SYS_NOTIFIER=/usr/local/bin/terminal-notifier

  ##### Path #####
  path=(
    $GOPATH(N-/)
    $GOPATH/bin(N-/)
    $RBENV_ROOT/bin(N-/)
    $PYENV_ROOT/bin(N-/)
    $NODENV_ROOT/bin(N-/)
    $GAE_GOPATH(N-/)
    $GCPPATH(N-/)
    $ANDROID_SDK_TOOLS(N-/)
    $ANDROID_SDK_PLATFORM_TOOLS(N-/)
    $path
  )

  [ -f $ZSH_CONF_DIR/.zshenv.secure ] && source $ZSH_CONF_DIR/.zshenv.secure

  export ZSHENV_LOADED=1
else
  echo '.zshenv load skipped'
fi

