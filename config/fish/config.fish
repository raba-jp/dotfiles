## XDG BASE DIRECTORY
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share

## Atom
set -x ATOM_HOME $XDG_DATA_HOME/atom

## Less
set -x LESSHISTFILE $XDG_CACHE_HOME/less/history

## MPlayer
set -x MPLAYER_HOME $XDG_CONFIG_HOME/mplayer

## ReadLine
set -x INPUTRC $XDG_CONFIG_HOME/readline/inputrc

## Editor
set -x EDITOR nvim

## Go
set -x GOPATH $HOME/Development
set -x GO15VENDOREXPERIMENT 1

## Android SDK
[ -e $HOME/Library/Android/sdk/tools ]; set -x ANDROID_SDK_TOOLS $HOME/Library/Android/sdk/tools
[ -e $HOME/Library/Android/sdk/platform-tools ]; set -x ANDROID_SDK_PLATFORM_TOOLS $HOME/Library/Android/sdk/platform-tools

## Terminal Notifier (OSX)
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

function done_enter --on-event fish_postexec
	if [ ! -z "$argv" ]
		return 0
	end

	echo
	echo -e (set_color yellow)"--- list files ---"(set_color normal)
	ls -alG
	if [ (git rev-parse --is-inside-work-tree 2> /dev/null) = 'true' ]

		echo
		echo -e (set_color yellow)"--- git status ---"(set_color normal)
		git status --short --branch
		echo

		set -l user_name (git config --get --local user.name)
		[ -z $user_name ]; and return 0
		if [ -n (git log -n 1 --oneline --author=$user_name) ]
			echo -e (set_color yellow)"--- last commit ---"(set_color normal)
			git log -n 1 --oneline --author=$user_name
		end
	end
end
