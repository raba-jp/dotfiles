darwin_pkg "hammerspoon" do
  options "--cask"
end

link File.expand_path("~/.hammerspoon") do
  to File.expand_path("cookbooks/hammerspoon/files")
end
