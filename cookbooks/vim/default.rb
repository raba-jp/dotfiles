# vim
manjaro_pkg "gvim"

darwin_pkg "vim"

link File.expand_path("~/.vim/vimrc") do
  force true
  to File.expand_path("cookbooks/vim/files/init.vim")
end

# neovim
manjaro_pkg "neovim-nightly-bin"

directory File.expand_path("~/.config/nvim")
link File.expand_path("~/.config/nvim/init.vim") do
  force true
  to File.expand_path("cookbooks/vim/files/init.vim")
end
