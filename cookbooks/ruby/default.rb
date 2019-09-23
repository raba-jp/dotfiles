# frozen_string_literal: true

package 'git'

node.reverse_merge!(
  rbenv: {
    rbenv_root: '/usr/local/rbenv',
    global: '2.6.4',
    versions: %w[
      2.6.4
    ]
  }
)

include_recipe 'rbenv::user'
