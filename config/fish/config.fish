## Alias
alias sudo 'sudo '
alias ls 'exa'
alias ll 'exa -alhG'
alias cat 'bat'
alias untar 'tar -xzvf'
alias tmux 'tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'
alias repo '__select_repository'
alias reload 'source $XDG_CONFIG_HOME/fish/config.fish'
alias reload-tmux 'tmux source $XDG_CONFIG_HOME/tmux/tmux.conf'
alias search-source '__search_source_code'
alias tree 'exa --tree'
alias dot 'cd $HOME/dotfiles'
alias grep 'rg'
alias find 'fd'
alias branch '__select_git_branch'
alias kubens 'command kubens (command kubens | peco)'
alias kubectx 'command kubectx (command kubectx | peco)'
alias update_skaffold 'curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-darwin-amd64; and chmod +x skaffold; and sudo mv skaffold /usr/local/bin'
alias fit_display 'xrandr --fb 7680x2160 --output DP3 --panning 3840x2160+0+0 --scale 2x2 --output eDP1 --panning 3840x2160+3840+0 --scale 1x1'

# Keybind
bind \cr __select_history
bind \cg __select_repository
bind \cf __search_from_filename
bind \ck up-or-search
bind \cj down-or-search
bind \ch backward-char
bind \cl forward-char
bind \cs beginning-of-line
bind \ce end-of-line

function done_enter --on-event fish_postexec
    __do_enter_action $argv
end

alias ssh "__peco_ssh"

[ (uname) = 'Darwin' ] && source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
# [ -n (type gcloud) ] && complete --command gcloud --arguments="($XDG_CONFIG_HOME/fish/gcloud_completion.py (commandline -cp))"
[ -n (type direnv) ] && eval (direnv hook fish)
status --is-interactive; and source (nodenv init -|psub)
status --is-interactive; and source (rbenv init -|psub)
[ -n (type starship) ] && starship init fish | source
