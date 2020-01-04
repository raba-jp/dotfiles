git "nodenv" do
  user node["user"]
  repository "https://github.com/nodenv/nodenv"
  destination "#{node["home"]}/.nodenv"
end

git "node-build" do
  user node["user"]
  repository "https://github.com/nodenv/node-build"
  destination "#{node["home"]}/.nodenv/plugins/node-build"
end
