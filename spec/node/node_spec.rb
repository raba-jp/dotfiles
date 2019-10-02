require 'spec_helper'

describe file("#{ENV['HOME']}/.local/share/nodenv/bin/nodenv") do
  it { should be_file }
  it { should be_executable }
end

describe file("#{ENV['HOME']}/.local/share/nodenv/shims/node") do
  it { should be_file }
  it { should be_executable }
end
