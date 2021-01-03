manjaro_pkg "alacritty"

darwin_pkg "alacritty" do
  options "--cask"
end

directory File.expand_path("~/.config/alacritty")

link File.expand_path("~/.config/alacritty/alacritty.yml") do
  force true
  to File.expand_path("cookbooks/alacritty/files/alacritty.yml")
end
