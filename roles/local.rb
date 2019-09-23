# frozen_string_literal: true

case node[:platform]
when 'ubuntu', 'mint'
  include_recipe '../cookbooks/ubuntu/default'
when 'darwin'
  include_recipe '../cookbooks/darwin/default'
end

include_recipe '../cookbooks/go/default'
include_recipe '../cookbooks/python/default'
include_recipe '../cookbooks/ruby/default'
include_recipe '../cookbooks/rust/default'
