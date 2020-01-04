define :ln do
  path = File.join("#{node["home"]}/.config/#{params[:name]}")
  link path do
    user node[:user]
    force params[:force]
    cwd params[:cwd]
    to File.expand_path("../../../config/#{params[:name]}", __FILE__)
  end
end
