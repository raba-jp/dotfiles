##### zplug #####
export ZPLUG_HOME=/usr/local/opt/zplug

##### XDG BASE DIRECTORY #####
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

##### Editor Path #####
export ATOM_HOME=$XDG_DATA_HOME/atom

#### #Common Path #####
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE=$XDG_CACHE_HOME/zsh/history
export EDITOR=nvim

##### npm Path #####
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

##### Language Path #####
export GOPATH=$HOME/Development
export ANYENV=$HOME/.anyenv/bin
if [ -d $HOME/.anyenv ]; then
  for D in `ls $HOME/.anyenv/envs`; do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done 
fi

##### Goolge App Engine SDK #####
export GAEPATH=$HOME/GoogleAppEngine
export GAE_GOPATH=$GAEPATH/go_appengine

##### Google Cloud SDK #####
export GCPPATH=$HOME/GoogleCloudSDK/bin

##### Android SDK #####
export ANDROID_SDK_TOOLS=$HOME/Library/Android/sdk/tools
export ANDROID_SDK_PLATFORM_TOOLS=$HOME/Library/Android/sdk/platform-tools

##### Path #####
path=(
  $GOPATH(N-/)
  $GOPATH/bin(N-/)
  $ANYENV(N-/)
  $GAE_GOPATH(N-/)
  $GCPPATH(N-/)
  $ANDROID_SDK_TOOLS(N-/)
  $ANDROID_SDK_PLATFORM_TOOLS(N-/)
  $path
)

fpath=(
  $ZDOTDIR/completion
  $fpath
)
