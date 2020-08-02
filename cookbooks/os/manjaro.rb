# TODO 手動で一度だけ実行するようにする
# execute "LANG=C xdg-user-dirs-gtk-update"
# execute "pacman-mirrors --fasttrack"


# Install yay and base-devel and system upgrade
execute "pacman -Syu --noconfirm"
package "base-devel"
package "yay"
execute "yay -Syu --noconfirm"

# Remove unused packages
rmpkg "gnome-terminal"
rmpkg "firefox"
rmpkg "gtkhash-nautilus"
rmpkg "gtkhash"
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
