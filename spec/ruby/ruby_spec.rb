require 'spec_helper'

describe file("#{ENV['HOME']}/.local/share/rbenv/bin/rbenv") do
  it { should be_file }
  it { should be_executable }
end

describe file("#{ENV['HOME']}/.local/share/rbenv/shims/ruby") do
  it { should be_file }
  it { should be_executable }
end
