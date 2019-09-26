# frozen_string_literal: true

USERNAME = 'sakuraba'

if ENV['USER'] != USERNAME
  node.reverse_merge!(
    install_user: USERNAME
  )
  user USERNAME
else
  node.reverse_merge!(
    install_user: ENV['USER']
  )
end
