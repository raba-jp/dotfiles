MItamae::RecipeContext.class_eval do
  def root_dir
    return File.expand_path("..", __FILE__)
  end

  def manjaro_linux?
    return false unless File.exists?("/etc/arch-release")
    file = File.open("/etc/arch-release", "r")
    return file.gets == "Manjaro Linux\n"
  end

  def darwin?
    `uname` == "Darwin\n"
  end

  def manjaro_cookbook(name)
    return File.join(root_dir, "cookbooks", name.to_s, "manjaro.rb")
  end

  def darwin_cookbook(name)
    return File.join(root_dir, "cookbooks", name.to_s, "darwin.rb")
  end

  def include_cookbook(name)
    preexec = File.join(root_dir, "cookbooks", name.to_s, "pre_exec.rb")
    postexec = File.join(root_dir, "cookbooks", name.to_s, "post_exec.rb")
    manjaro = manjaro_cookbook(name)
    darwin = darwin_cookbook(name)

    include_recipe preexec if File.exists? preexec
    include_recipe File.join(root_dir, "cookbooks", name.to_s, "default.rb")

    include_recipe manjaro if manjaro_linux? && File.exists?(manjaro)
    include_recipe darwin if darwin? && File.exists?(darwin)

    include_recipe postexec if File.exists? postexec
  end

  def include_definitions(name)
    root_dir = File.expand_path("..", __FILE__)
    include_recipe File.join(root_dir, "definitions", "#{name.to_s}.rb")
  end
end

directory File.expand_path("~/.config")
directory File.expand_path("~/.local/share")
directory File.expand_path("~/.cache")
directory File.expand_path("~/.local/bin")

include_definitions :pkg
include_definitions :rmpkg

include_cookbook :darwin if darwin?
include_cookbook :manjaro if manjaro_linux?

## Tools
include_cookbook :fish
include_cookbook :alacritty
include_cookbook :git
include_cookbook :vim
include_cookbook :vscode
include_cookbook :tmux
include_cookbook :docker
include_cookbook :hammerspoon if darwin?

## Programming Languages
include_cookbook :go
include_cookbook :ruby
include_cookbook :rust
include_cookbook :node
include_cookbook :lua


# include_cookbook :gnome3 if manjaro_linux?
