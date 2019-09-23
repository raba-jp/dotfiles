# frozen_string_literal: true

node.reverse_merge!(
  go: {
    version: '1.13',
    root_path: '/usr/local',
    user: 'root',
    install_dependency: true,
    create_symlink: true
  }
)

include_recipe './install'
