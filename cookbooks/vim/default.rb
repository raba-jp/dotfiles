if arch_linux?
  # +clipboardのためにgvimを入れる
  pkg "gvim"
elsif darwin?
  pkg "vim"
end

# Install volt
execute "curl -Lo /tmp/volt https://github.com/vim-volt/volt/releases/download/v0.3.7/volt-v0.3.7-linux-amd64" do
  user node["user"]
  not_if "test -e /usr/local/bin/volt"
end

execute "chmod +x /tmp/volt" do
  user node["user"]
  not_if "test -e /usr/local/bin/volt"
end

execute "mv /tmp/volt /usr/local/bin/volt" do
  user "root"
  not_if "test -e /usr/local/bin/volt"
end

directory "#{node["home"]}/.config/volt" do
  user node["user"]
end

ln "volt/lock.json"
ln "volt/plugconf"
ln "volt/rc"
