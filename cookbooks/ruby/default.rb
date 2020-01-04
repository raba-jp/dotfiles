git "rbenv" do
  user node["user"]
  repository "https://github.com/rbenv/rbenv"
  destination "#{node["home"]}/.rbenv"
end

git "ruby-build" do
  user node["user"]
  repository "https://github.com/rbenv/ruby-build"
  destination "#{node["home"]}/.rbenv/plugins/ruby-build"
end
