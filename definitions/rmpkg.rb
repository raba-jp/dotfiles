define :rmpkg do
  name = params[:name]
  package name do
    action :remove
    user params[:user]
    cwd params[:cwd]
    version params[:version]
    options params[:options]
  end
end
