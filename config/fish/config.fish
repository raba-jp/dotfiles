## Alias
alias sudo 'sudo '

if status --is-interactive
  abbr --add --global ls 'exa'
  abbr --add --global ll 'exa -alhG'
  abbr --add --global cat 'bat'
  abbr --add --global grep 'rg'
  abbr --add --global find 'fd'
  abbr --add --global tree 'exa --tree'
  abbr --add --global ps 'procs'
  abbr --add --global tmux 'tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
  abbr --add --global update_skaffold 'curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64; and chmod +x skaffold; and sudo mv skaffold /usr/local/bin'
  abbr --add --global fit_display 'xrandr --fb 7680x2160 --output DP-3 --panning 3840x2160+0+0 --scale 2x2 --output eDP-1 --panning 3840x2160+3840+0 --scale 1x1'
  abbr --add --global dot 'cd $HOME/dotfiles'
  abbr --add --global gc 'git commit'
  abbr --add --global untar 'tar -xzvf'
  abbr --add --global pacinstall 'yay -Slq | fzf -m --preview \'yay -Si {1}\' | xargs -ro yay -S'
  abbr --add --global pacremove 'yay -Qeq | fzf -m --preview \'yay -Qi {1}\' | xargs -ro yay -Rs'
  abbr --add --global repo 'cd (ghq list | fzf --select-1 | xargs echo $GOPATH/src/ | sed "s/ //")'
  abbr --add --global ssh 'rg --ignore-case \'^host [^*]\' ~/.ssh/config | cut -d \' \' -f 2 | fzf --select-1 | read -l __ssh_hostname && ssh $__ssh_hostname'
end

function __select_history
  history | fzf --select-1 | read -l history_result && commandline $history_result
end

# Keybind
bind \cr __select_history
bind \ck up-or-search
bind \cj down-or-search
bind \ch backward-char
bind \cl forward-char
bind \cs beginning-of-line
bind \ce end-of-line

function done_enter --on-event fish_postexec
    __do_enter_action $argv
end

function wakatime_hook --on-event fish_prompt
  set -l project

  if echo (pwd) | grep -qEi "^/Users/$USER/Sites/"
    set  project (echo (pwd) | sed "s#^/Users/$USER/Sites/\\([^/]*\\).*#\\1#")
  else
    set  project "Terminal"
  end

  wakatime --write --plugin "fish-wakatime/0.0.1" --entity-type app --project "$project" --entity (echo $history[1] | cut -d ' ' -f1) 2>&1 > /dev/null&
end

[ (uname) = 'Darwin' ] && source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
# [ -n (type gcloud) ] && complete --command gcloud --arguments="($XDG_CONFIG_HOME/fish/gcloud_completion.py (commandline -cp))"
[ -n (type direnv) ] && eval (direnv hook fish)
status --is-interactive; and source (nodenv init -|psub)
status --is-interactive; and source (rbenv init -|psub)
[ -n (type starship) ] && starship init fish | source
