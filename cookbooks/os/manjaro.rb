execute "LANG=C xdg-user-dirs-gtk-update"

# Install yay and system upgrade
execute "pacman -Syu"
package "yay"
execute "pacman-mirrors --fasttrack"
execute "yay -Syuu"

# Remove unused packages
rmpkg "gnome-terminal"
rmpkg "firefox"
rmpkg "gtkhash"
rmpkg "gtkhash-nautilus"
rmpkg "hexchat"
rmpkg "gnome-calculator"

# Setup user
group node["user"] do
  user "root"
  gid 1000
end

user node["user"] do
  user "root"
  uid 1000
  gid node["user"]
  create_home true
end

execute "usermod -aG input #{node["user"]}" do
  user "root"
end

remote_file "#{node["home"]}/.xprofile" do
  source File.join(File.expand_path("../../..", __FILE__), "config", "xprofile")
  owner node["user"]
  group node["user"]
end

file "#{node["home"]}/.xprofile" do
  owner node["user"]
  group node["user"]
end

directory "#{node["home"]}/.config"
