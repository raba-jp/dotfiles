darwin_pkg "tmux"
manjaro_pkg "tmux"

directory File.expand_path("~/.config/tmux")

link File.expand_path("~/.config/tmux/tmux.conf") do
  force true
  to File.expand_path("cookbooks/tmux/files/tmux.conf")
end

git "tpm" do
  repository "https://github.com/tmux-plugins/tpm"
  destination File.expand_path("~/.local/share/tpm")
end

execute "#{File.expand_path("~/.local/share/tpm/bin/install_plugins")}"
