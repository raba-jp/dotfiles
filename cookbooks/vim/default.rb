manjaro_pkg "gvim"

darwin_pkg "vim"

link File.expand_path("~/.vim/vimrc") do
  force true
  to File.expand_path("cookbooks/vim/files/init.vim")
end
