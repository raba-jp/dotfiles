Pry.config.prompt = proc do |obj, nest_level, _pry_|
  "#{RUBY_VERSION} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})> "
end

if defined?(PryDebugger)
  Pry.config.commands.alias_command 'c', 'continue'
  Pry.config.commands.alias_command 's', 'step'
  Pry.config.commands.alias_command 'n', 'next'
  Pry.config.commands.alias_command 'f', 'finish'
end
