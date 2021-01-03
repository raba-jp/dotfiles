define :manjaro_pkg do
  next unless manjaro_linux?

  package "yay" do
    user "root"
    cwd params[:cwd]
  end

  execute "yay -S --noconfirm powerpill" do
    not_if "which powerpill"
    user ENV["USER"]
    cwd params[:cwd]
  end

  name = params[:name].shellescape
  execute "yay -S --noconfirm #{name}" do
    not_if "yay -Q #{name} || yay -Qg #{name}"
    user ENV["USER"]
    cwd params[:cwd]
  end
end

define :darwin_pkg, options: "" do
  next unless darwin?

  name = params[:name].shellescape
  package name do
    user params[:user]
    cwd params[:cwd]
    options params[:options]
  end
end
