require 'spec_helper'

describe file('/usr/local/rbenv/bin/rbenv') do
  it { should be_file }
  it { should be_executable }
end

describe file('/usr/local/rbenv/shims/ruby') do
  it { should be_file }
  it { should be_executable }
end
