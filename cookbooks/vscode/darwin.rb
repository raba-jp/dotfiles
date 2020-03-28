link "#{node["home"]}/Library/Application\ Support/Code/User/settings.json" do
  user node["user"]
  to File.expand_path("../../../config/Code/User/settings.json", __FILE__)
end

link "#{node["home"]}/Library/Application\ Support/Code/User/keybindings.json" do
  user node["user"]
  to File.expand_path("../../../config/Code/User/keybindings.json", __FILE__)
end

link "#{node["home"]}/Library/Application\ Support/Code/User/locale.json" do
  user node["user"]
  to File.expand_path("../../../config/Code/User/locale.json", __FILE__)
end

link "#{node["home"]}/Library/Application\ Support/Code/User/projects.json" do
  user node["user"]
  to File.expand_path("../../../config/Code/User/projects.json", __FILE__)
end
