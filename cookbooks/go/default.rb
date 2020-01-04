directory "#{node["home"]}/dev" do
  user node["user"]
end

pkg "go"
