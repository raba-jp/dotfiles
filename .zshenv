if [ -z $ZSHEMV_LOADED ]; then
  ##### XDG BASE DIRECTORY #####
  export XDG_CONFIG_HOME=$HOME/.config
  export XDG_CACHE_HOME=$HOME/.cache
  export XDG_DATA_HOME=$HOME/.local/share

  ##### zplug #####
  export ZPLUG_HOME=$XDG_CACHE_HOME/zsh/zplug

  ##### Editor Path #####
  export ATOM_HOME=$XDG_DATA_HOME/atom

  #### #Common Path #####
  export LESSHISTFILE=$XDG_CACHE_HOME/less/history
  export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
  export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
  export ZDOTDIR=$XDG_CONFIG_HOME/zsh
  export HISTFILE=$XDG_CACHE_HOME/zsh/history
  export EDITOR=nvim

  ##### Go #####
  export GOPATH=$HOME/Development

  ##### Ruby #####
  export RBENV_ROOT=$XDG_CACHE_HOME/rbenv
  export RBENV_SHELL=zsh

  ##### Python #####
  export PYENV_ROOT=$XDG_CACHE_HOME/pyenv
  export PYENV_SHELL=zsh

  ##### Node.js #####
  export NODENV_ROOT=$XDG_CACHE_HOME/nodenv
  export NODENV_SHELL=zsh

  ##### Goolge App Engine SDK #####
  export GAEPATH=$HOME/GoogleAppEngine
  export GAE_GOPATH=$GAEPATH/go_appengine

  ##### Google Cloud SDK #####
  export GCPPATH=$HOME/GoogleCloudSDK/bin

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


  export ZSHENV_LOADED=1
else
  print '.zshenv load skipped'
fi

