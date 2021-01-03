git "rbenv" do
  repository "https://github.com/rbenv/rbenv"
  destination File.expand_path("~/.rbenv")
end

directory File.expand_path("~/.rbenv/plugins")

git "ruby-build" do
  repository "https://github.com/rbenv/ruby-build"
  destination File.expand_path("~/.rbenv/plugins/ruby-build")
end
