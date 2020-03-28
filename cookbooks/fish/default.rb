pkg "fish"

if arch_linux?
  # alacritty用に /usr/local/bin 以下にシンボリックリンクを貼る
  link "/usr/local/bin/fish" do
    user "root"
    to "/usr/bin/fish"
  end
end

[
  { name: "XDG_CONFIG_HOME", value: "$HOME/.config" },
  { name: "XDG_CACHE_HOME", value: "$HOME/.cache" },
  { name: "XDG_DATA_HOME", value: "$HOME/.local/share" },
  { name: "LESSHISTFILE", value: "$HOME/.cache/less/history" },
  { name: "MPLAYER_HOME", value: "$HOME/.config/mplayer" },
  { name: "INPUTRC", value: "$HOME/.config/readline/inputrc" },
  { name: "EDITOR", value: "vim" },
  { name: "GOPATH", value: "$HOME/dev" },
  { name: "RBENV_ROOT", value: "$HOME/.rbenv" },
  { name: "NODENV_ROOT", value: "$HOME/.nodenv" },
  { name: "VOLTPATH", value: "$HOME/.config/volt" },
].each do |item|
  execute "fish --command 'set --universal --export #{item[:name]} #{item[:value]}'" do
    user node["user"]
  end
end

paths = [
  "$GOPATH/bin",
  "$RBENV_ROOT/bin",
  "$NODENV_ROOT/bin",
  "$XDG_DATA_HOME/flutter/bin",
  "$XDG_DATA_HOME/dart-sdk/bin",
].join(" ")

execute "fish --command 'set --universal fish_user_paths #{paths}'" do
  user node["user"]
end

execute "curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish" do
  user node["user"]
  not_if "type fisher"
end

ln "fish/config.fish" do
  user node["user"]
end
ln "fish/fishfile" do
  user node["user"]
end
