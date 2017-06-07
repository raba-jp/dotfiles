set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x ATOM_HOME $XDG_DATA_HOME/atom
set -x LESSHISTFILE $XDG_CACHE_HOME/less/history
set -x MPLAYER_HOME $XDG_CONFIG_HOME/mplayer
set -x INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -x EDITOR nvim
set -x GO15VENDOREXPERIMENT 1
set -x GOPATH $HOME/Development
[ -e $HOME/Library/Android/sdk/tools ]; and set -x ANDROID_SDK_TOOLS $HOME/Library/Android/sdk/tools
[ -e $HOME/Library/Android/sdk/platform-tools ]; and set -x ANDROID_SDK_PLATFORM_TOOLS $HOME/Library/Android/sdk/platform-tools
set -x SYS_NOTIFIER /usr/local/bin/terminal-notifier

set -x PATH $GOPATH/bin $ANDROID_SDK_TOOLS/bin $ANDROID_SDK_PLATFORM_TOOLS $PATH

## Alias
alias vi 'nvim'
alias vim 'nvim'
alias sudo 'sudo '
alias ll 'ls -alG'
alias untar 'tar -xzvf'
alias tmux 'tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'
alias repo 'peco_select_repository'

# Keybind
function fish_user_key_bindings
	bind \cr peco_select_history
	bind \ck up-or-search
	bind \cj down-or-search
	bind \ch backward-char
	bind \cl forward-char
end

function done_enter --on-event fish_postexec
	enter_action $argv
end

eval (direnv hook fish)
