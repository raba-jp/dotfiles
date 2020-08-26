pkg "cask hammerspoon"
link "#{node["home"]}/.hammerspoon" do
  user node["user"]
  to File.expand_path("../../../config/hammerspoon", __FILE__)
end
