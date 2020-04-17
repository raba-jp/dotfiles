define :pkg do
  name = params[:name].shellescape
  if manjaro_linux?
    execute "yay -S --noconfirm #{name}" do
      not_if "yay -Q #{name} || yay -Qg #{name}"
      user node["user"]
    end
  elsif name.start_with? "cask" 
    pkg_name = params[:name].gsub("cask ", "")
    execute "brew cask install #{pkg_name}" do
      not_if "brew cask list | grep #{pkg_name}"
      user node["user"]
    end
  else
    package name do
      user params[:user]
      cwd params[:cwd]
      version params[:version]
      options params[:options]
    end
  end
end
