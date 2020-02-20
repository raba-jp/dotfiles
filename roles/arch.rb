include_cookbook :symlink

pkg "yay"
execute "yay -Sy"

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

package "firefox" { action :remove }

# development
pkg "autoconf"
pkg "automake"
pkg "base-devel"
pkg "binutils"
pkg "base-devel"
pkg "fakeroot"
pkg "make"
pkg "gcc"
pkg "git"
pkg "exa"
pkg "fd"
pkg "bat"
pkg "ghq"
pkg "tig"
pkg "fish"
pkg "ripgrep"
pkg "kubectl"
pkg "kubectx"
pkg "tmux"
pkg "vim"
pkg "noto-fonts"
pkg "noto-fonts-cjk"
pkg "noto-fonts-extra"
pkg "peco"
pkg "direnv"
pkg "google-chrome"
pkg "ttf-cica"
pkg "ttf-hackgen"
pkg "station"
pkg "starship-bin"
pkg "ghq"
pkg "gnome-tweak-tool"
pkg "python-pynvim"

# IME
pkg "fcitx"
pkg "fcitx-configtool"
pkg "fcitx-mozc"
pkg "fcitx-gtk3"
# GNOME 3 theme
pkg "materia-gtk-theme"
pkg "gnome-themes-extra"
pkg "gtk-engine-murrine"

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


link "#{node["home"]}/.xprofile" do
  user node[:user]
  to File.expand_path("../config/xprofile", __FILE__)
end

