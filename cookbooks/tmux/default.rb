pkg "tmux"
ln "tmux"

git "tpm" do
  user node["user"]
  repository "https://github.com/tmux-plugins/tpm"
  destination "#{node["home"]}/.local/share/tpm"
end
