darwin_pkg "fish"
manjaro_pkg "fish"

link File.expand_path("~/.config/fish/config.fish") do
  force true
  to File.expand_path("cookbooks/fish/files/config.fish")
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
  { name: "VOLTA_HOME", value: "$HOME/.local/share/volta" },
].each do |item|
  execute "fish --command 'set --universal --export #{item[:name]} #{item[:value]}'"
end

paths = [
  "$GOPATH/bin",
  "$RBENV_ROOT/bin",
  "$VOLTA_HOME/bin",
  "$HOME/.tfenv/bin",
  "$HOME/.cargo/bin",
].join(" ")

execute "fish --command 'set --universal fish_user_paths #{paths}'"

link File.expand_path("~/.config/fish/fish_plugins") do
  force true
  to File.expand_path("cookbooks/fish/files/fish_plugins")
end

execute "curl -sL https://git.io/fisher | fish --command 'source && fisher update'" do
  not_if "type fisher"
end

if manjaro_linux?
  # alacritty用に /usr/local/bin 以下にシンボリックリンクを貼る
  link "/usr/local/bin/fish" do
    user "root"
    to "/usr/bin/fish"
  end
end
