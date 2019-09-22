# frozen_string_literal: true

case node[:platform]
when 'darwin'
  package 'python@2'
  package 'python'
when 'ubuntu', 'mint'
  package 'python-dev'
  package 'python-pip'
  package 'python3-dev'
  package 'python3-pip'
end
