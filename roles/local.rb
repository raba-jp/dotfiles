# frozen_string_literal: true

case node[:platform]
when 'ubuntu', 'mint'
  include_recipe 'cookbooks/ubuntu/default'
when 'darwin'
  include_cookbook 'cookbooks/darwin/default'
end

include_cookbook 'cookbooks/go/default'
include_cookbook 'cookbooks/python/default'
include_cookbook 'cookbooks/ruby/default'
include_cookbook 'cookbooks/rust/default'
