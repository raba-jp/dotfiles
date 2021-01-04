darwin_pkg "hammerspoon" do
  options "--cask"
end

link File.expand_path("~/.hammerspoon") do
  force true
  to File.expand_path("cookbooks/hammerspoon/files")
end
