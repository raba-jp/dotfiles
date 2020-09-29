link "#{node["home"]}/.vim/vimrc" do
  user node["user"]
  to File.expand_path("../../../config/vim/init.vim", __FILE__)
end
