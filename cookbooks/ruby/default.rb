# frozen_string_literal: true

node.reverse_merge!(
  rbenv: {
    user: 'sakuraba',
    global: '2.6.4',
    versions: %w[
      2.6.4
    ]
  }
)

package 'git'

include_recipe 'rbenv::user'
