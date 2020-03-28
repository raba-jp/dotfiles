MItamae::RecipeContext.class_eval do
  def include_cookbook(name)
    name = name.to_s
    root_dir = File.expand_path('..', __FILE__)
    include_recipe File.join(root_dir, 'cookbooks', name, 'default')
  end

  def include_role(name)
    root_dir = File.expand_path('..', __FILE__)
    include_recipe File.join(root_dir, 'roles', "#{name}.rb")
  end

  def arch_linux?
    executable = true
    result = false
    lambda do
      return result if executable

      executable = false
      result = true if File.exists? "/etc/arch-release"

      return result
    end
  end

  def darwin?
    `uname` == "Darwin"
  end
end

define :pkg do
  name = params[:name].shellescape
  if arch_linux?
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

define :ln do
  path = File.join("#{node["home"]}/.config/#{params[:name]}")
  link path do
    user node[:user]
    force params[:force]
    cwd params[:cwd]
    to File.expand_path("../../../config/#{params[:name]}", __FILE__)
  end
end

# Arch Linux
include_role "arch"
