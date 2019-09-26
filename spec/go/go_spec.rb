# frozen_string_literal: true

require 'spec_helper'

describe command('go version') do
  its(:exit_status) { should eq 0 }
end

%w[
  direnv
  gore
  gocode
  gopls
  ghq
].each do |pkg|
  describe file("#{ENV['HOME']}/dev/bin/#{pkg}") do
    it { should be_file }
    it { should be_executable }
  end
end

[
  'github.com/direnv/direnv',
  'github.com/motemen/gore',
  'github.com/k0kubun/pp',
  'github.com/mdempsky/gocode',
  'golang.org/x/tools/cmd/gopls',
  'github.com/motemen/ghq'
].each do |pkg|
  describe file("#{ENV['HOME']}/dev/src/#{pkg}") do
    it { should be_directory }
    it { should be_owned_by ENV['USER'] }
  end
end
