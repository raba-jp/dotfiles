MItamae::RecipeContext.class_eval do
  def include_cookbook(name)
    root_dir = File.expand_path("..", __FILE__)
    include_recipe(File.join(root_dir, "cookbooks", name.to_s, "default"))
  end

  def include_role(name)
    root_dir = File.expand_path("..", __FILE__)
    include_recipe(File.join(root_dir, "roles", "#{name}.rb"))
  end

  def include_definitions(name)
    root_dir = File.expand_path("..", __FILE__)
    include_recipe(File.join(root_dir, "definitions", "#{name.to_s}.rb"))
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

[:pkg, :rmpkg, :ln].each do |de|
  include_definitions de
end

if arch_linux?
  # Arch Linux
  include_role "arch"
end

if darwin?
  include_role "darwin"
end
