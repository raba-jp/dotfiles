define :pkg do
  name = params[:name].shellescape
  if manjaro_linux?
    execute "yay -S --noconfirm #{name}" do
      not_if "yay -Q #{name} || yay -Qg #{name}"
      user node["user"]
    end
  elsif darwin?
    execute "brew #{name}"
  else
    package name do
      action params[:action]
      user params[:user]
      cwd params[:cwd]
      version params[:version]
      options params[:options]
    end
  end
end
