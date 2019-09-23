# frozen_string_literal: true

GO_VERSION = '1.13'

if node[:platform] == 'darwin'
  execute 'download tar' do
    command "wget -O go#{GO_VERSION}.tar.gz https://dl.google.com/go/go#{GO_VERSION}.darwin-amd64.tar.gz"
    not_if 'type go'
  end
else
  execute 'download tar' do
    command "wget -O go#{GO_VERSION}.tar.gz https://dl.google.com/go/go#{GO_VERSION}.linux-amd64.tar.gz"
    not_if 'type go'
  end
end

execute 'untar' do
  command "tar -C /usr/local -xzf go#{GO_VERSION}.tar.gz"
  not_if 'type go'
end

['go', 'gofmt'].each do |cmd|
  link "/usr/local/go/bin/#{cmd}" do
    to "/usr/local/bin/#{cmd}"
    not_if "type #{cmd}"
  end
end

directory "#{ENV['HOME']}/dev/src" do
  action :create
end

# Install Go tools
## gore
execute 'go get gore' do
  command 'GO111MODULE=off go get -u github.com/motemen/gore/cmd/gore'
  not_if 'type gore'
end

execute 'go get gocode' do
  command 'GO111MODULE=off go get -u github.com/mdempsky/gocode'
  not_if 'type gocode'
end

execute 'go get pp' do
  command 'GO111MODULE=off go get -u github.com/k0kubun/pp'
  not_if "test -d #{ENV['HOME']}/dev/src/github.com/k0kubun/pp"
end

# Install ghq
execute 'go get ghq' do
  command 'go get github.com/motemen/ghq'
  not_if 'type ghq'
end
