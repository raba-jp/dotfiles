current_user = ENV["USER"]

package "base-devel"
package "yay"
manjaro_pkg "autoconf"
manjaro_pkg "automake"
manjaro_pkg "base-devel"
manjaro_pkg "binutils"
manjaro_pkg "base-devel"
manjaro_pkg "fakeroot"
manjaro_pkg "python-pynvim"
manjaro_pkg "gcc"
manjaro_pkg "lm_sensors"
manjaro_pkg "libinput-gestures"

# Setup user
group current_user do
  user "root"
  gid 1000
end

user current_user do
  user "root"
  uid 1000
  gid current_user
  create_home true
end

execute "usermod -aG input #{current_user}" do
  user "root"
end

remote_file File.expand_path("~/.xprofile") do
  source File.expand_path("cookbooks/manjaro/files/xprofile")
end

# GUI applications
manjaro_pkg "google-chrome"
manjaro_pkg "station"
manjaro_pkg "gnome-tweak-tool"
manjaro_pkg "bitwarden"
manjaro_pkg "android-studio"

# Fonts
manjaro_pkg "noto-fonts"
manjaro_pkg "noto-fonts-cjk"
manjaro_pkg "noto-fonts-extra"
manjaro_pkg "ttf-cica"
manjaro_pkg "ttf-hackgen"

# CLI tools
manjaro_pkg "patch"
manjaro_pkg "kubectl"
manjaro_pkg "lefthook"
manjaro_pkg "stern-bin"
manjaro_pkg "minikube"
manjaro_pkg "skaffold"

# IME
manjaro_pkg "fcitx"
manjaro_pkg "fcitx-configtool"
manjaro_pkg "fcitx-mozc"
manjaro_pkg "fcitx-gtk3"

# GNOME 3 theme
manjaro_pkg "materia-gtk-theme"
manjaro_pkg "gnome-themes-extra"
manjaro_pkg "gtk-engine-murrine"
manjaro_pkg "arc-gtk-theme"

manjaro_pkg "bat"
manjaro_pkg "bitwarden-cli"
manjaro_pkg "dive"
manjaro_pkg "direnv"
manjaro_pkg "exa"
manjaro_pkg "fd"
manjaro_pkg "fzf"
manjaro_pkg "ghq"
manjaro_pkg "jq"
manjaro_pkg "make"
manjaro_pkg "nkf"
manjaro_pkg "ripgrep"
manjaro_pkg "procs"
manjaro_pkg "kubectx"
manjaro_pkg "starship"
manjaro_pkg "flutter"
