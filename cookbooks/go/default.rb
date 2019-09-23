# frozen_string_literal: true

GO_VERSION = '1.13'

package 'git'

execute 'check $GOROOT' do
  command 'echo $GOROOT'
end
if node[:platform] == 'darwin'
  execute 'download tar' do
    command "wget -O go#{GO_VERSION}.tar.gz https://dl.google.com/go/go#{GO_VERSION}.darwin-amd64.tar.gz"
    not_if 'test -d /usr/local/go'
  end
else
  execute 'download tar' do
    command "wget -O go#{GO_VERSION}.tar.gz https://dl.google.com/go/go#{GO_VERSION}.linux-amd64.tar.gz"
    not_if 'test -d /usr/local/go'
  end
end

execute 'untar' do
  command "tar -C /usr/local -xzf go#{GO_VERSION}.tar.gz"
  not_if 'test -d /usr/local/go'
end

%w[go gofmt].each do |cmd|
  link "/usr/local/bin/#{cmd}" do
    to "/usr/local/go/bin/#{cmd}"
    not_if "test -x /usr/local/bin/#{cmd}"
  end
end

directory "#{ENV['HOME']}/dev/src" do
  action :create
end

execute 'check $GOROOT' do
  command 'echo $GOROOT'
end

[
  {
    name: 'gore',
    pkg: 'github.com/motemen/gore',
    cmd: 'github.com/motemen/gore/cmd/gore'
  },
  {
    name: 'ghq',
    pkg: 'github.com/motemen/ghq',
    cmd: 'github.com/motemen/ghq'
  }
].each do |c|
  execute "go get #{c[:name]}" do
    command "GO111MODULE=off go get -u #{c[:pkg]}"
    not_if "type #{c[:name]}"
  end
  execute "go install #{c[:name]}" do
    command "GO111MODULE=off go install #{c[:cmd]}"
    not_if "type #{c[:name]}"
  end
end

[
  'github.com/mdempsky/gocode',
  'github.com/k0kubun/pp'
].each do |pkg|
  execute "go get #{pkg}" do
    command "GO111MODULE=off go get -u #{pkg}"
    not_if "test -d #{ENV['GOPATH']}/src/#{pkg}"
  end
end
