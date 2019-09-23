require 'spec_helper'

describe package('rbenv') do
  it { should be_installed }
end

describe command('ruby -v') do
  its(:exit_status) { should eq 0 }
end
