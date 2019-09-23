require 'spec_helper'

describe package('go') do
  it { should be_installed }
end

describe package('gore') do
  it { should be_installed }
end

describe file("#{ENV['HOME']}/dev/src/github.com/mdempsky/gocode") do
  it { should be_directory }
end

describe file("#{ENV['HOME']}/dev/src/github.com/k0kubun/pp") do
  it { should be_directory }
end

describe package('ghq') do
  it { should be_installed }
end

describe file("#{ENV['HOME']}/dev/src") do
  it { should be_directory }
end
