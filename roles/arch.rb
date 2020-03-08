include_cookbook :symlink

execute "LANG=C xdg-user-dirs-gtk-update"
execute "pacman-mirrors --fasttrack"
execute "yay -Syuu"

package "yay"

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

# development
pkg "autoconf"
pkg "automake"
pkg "base-devel"
pkg "binutils"
pkg "base-devel"
pkg "fakeroot"
pkg "python-pynvim"
pkg "make"
pkg "gcc"
pkg "lm_sensors"
pkg "libinput-gestures"

# GUI applications
pkg "google-chrome"
pkg "station"
pkg "gnome-tweak-tool"
pkg "dbeaver"

# Fonts
pkg "noto-fonts"
pkg "noto-fonts-cjk"
pkg "noto-fonts-extra"
pkg "ttf-cica"
pkg "ttf-hackgen"

# Shell
pkg "fish"
pkg "starship-bin"

# CLI tools
pkg "bat"
pkg "bitwarden-cli-bin"
pkg "direnv"
pkg "dive"
pkg "exa"
pkg "fd"
pkg "fzf"
pkg "ghq-bin"
pkg "git"
pkg "kubectl"
pkg "kubectx"
pkg "procs-bin"
pkg "ripgrep"
pkg "tig"
pkg "tmux"
pkg "vim"

# IME
pkg "fcitx"
pkg "fcitx-configtool"
pkg "fcitx-mozc"
pkg "fcitx-gtk3"

# GNOME 3 theme
pkg "materia-gtk-theme"
pkg "gnome-themes-extra"
pkg "gtk-engine-murrine"
pkg "arc-gtk-theme"

directory "#{node["home"]}/.config"

include_cookbook :git
include_cookbook :alacritty
include_cookbook :clojure
include_cookbook :go
include_cookbook :node
include_cookbook :tmux
include_cookbook :inkdrop
include_cookbook :ruby
include_cookbook :packages
include_cookbook :docker
include_cookbook :rust
include_cookbook :fish
include_cookbook :vscode
include_cookbook :vim
include_cookbook :peco


remote_file "#{node["home"]}/.xprofile" do
  source File.expand_path("../config/xprofile", __FILE__)
  user node["user"]
  owner node["user"]
  group node["user"]
end
