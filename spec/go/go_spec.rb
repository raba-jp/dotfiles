# frozen_string_literal: true

require 'spec_helper'

describe 'go' do
  describe file("#{ENV['HOME']}/.local/share/go/bin/go") do
    it { should be_file }
    it { should be_executable }
  end
end

describe 'gofmt' do
  describe file("#{ENV['HOME']}/.local/share/go/bin/gofmt") do
    it { should be_file }
    it { should be_executable }
  end

  describe command("#{ENV['HOME']}/.local/share/go/bin/go version") do
    its(:exit_status) { should eq 0 }
  end
end

describe file("#{ENV['HOME']}/dev/src") do
  it { should be_directory }
end

describe file("#{ENV['GOPATH']}/bin/gore") do
  it { should be_file }
  it { should be_executable }
end

describe file("#{ENV['GOPATH']}/bin/ghq") do
  it { should be_file }
  it { should be_executable }
end

describe file("#{ENV['GOPATH']}/src/github.com/mdempsky/gocode") do
  it { should be_directory }
  it { should be_owned_by ENV['USER'] }
end

describe file("#{ENV['GOPATH']}/src/github.com/k0kubun/pp") do
  it { should be_directory }
  it { should be_owned_by ENV['USER'] }
end