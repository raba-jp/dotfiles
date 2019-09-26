# frozen_string_literal: true

require 'spec_helper'

describe command('go version') do
  its(:exit_status) { should eq 0 }
end

describe file("#{ENV['HOME']}/dev/bin/gore") do
  it { should be_file }
  it { should be_executable }
end

describe file("#{ENV['HOME']}/dev/bin/ghq") do
  it { should be_file }
  it { should be_executable }
end

describe file("#{ENV['HOME']}/dev/src/github.com/mdempsky/gocode") do
  it { should be_directory }
  it { should be_owned_by ENV['USER'] }
end

describe file("#{ENV['HOME']}/dev/src/github.com/k0kubun/pp") do
  it { should be_directory }
  it { should be_owned_by ENV['USER'] }
end
