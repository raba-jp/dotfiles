define :ln do
  path = File.join("#{node["home"]}/.config/#{params[:name]}")
  root_dir = File.expand_path("../..", __FILE__)

  link path do
    user node[:user]
    force params[:force]
    cwd params[:cwd]
    to File.join(root_dir, "config/", params[:name])
  end
end
