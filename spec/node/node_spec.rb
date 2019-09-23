require 'spec_helper'

describe package('nodenv') do
  it { should be_installed }

  describe command('node -v') do
    its(:exit_status) { should eq 0 }
  end
end