pkg "glibc"
pkg "libcanberra"
pkg "gvfs"
pkg "visual-studio-code-bin"

directory "#{node["home"]}/.config/Code/User" do
  user node["user"]
end

[
  "Code/User/settings.json",
  "Code/User/keybindings.json",
  "Code/User/locale.json",
  "Code/User/projects.json",
].each do |item|
  ln item do
    user node["user"]
  end
end
