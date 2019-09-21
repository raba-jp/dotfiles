# frozen_string_literal: true

require 'spec_helper'

describe package('fish') do
  it { should be_installed }

  describe file("#{ENV['HOME']}/.config/fish/config.fish") do
    it { should be_file }
    it { should be_readable }
  end

  describe file('/etc/shells') do
    it { should contain 'fish' }
  end

  describe command('dscl localhost -read Local/Default/Users/$USER UserShell'), if: os[:family] == 'darwin' do
    its(:stdout) { should contain 'fish' }
  end
  
  describe file('/etc/passwd'), if: os[:family] == 'ubuntu' do
    its(:stdout) { should contain 'fish' }
  end

  describe file("#{ENV['HOME']}/.config/fish/fishfile") do
    it { should be_file }
    it { should be_readable }
  end
end
