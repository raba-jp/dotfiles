# frozen_string_literal: true

include_recipe '../user/default'

node.reverse_merge!(
  go: {
    version: '1.13',
    root_path: "#{ENV['HOME']}/.local/share",
    user: node[:install_user],
    install_dependency: true,
    create_symlink: false
  }
)

CMD = "#{ENV['HOME']}/.local/share/go/bin/go"

include_recipe './install'

directory "#{ENV['HOME']}/dev/src" do
  action :create
  user node[:install_user]
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
    command "#{CMD} get -u #{c[:pkg]}"
    user node[:install_user]
    not_if "type #{c[:name]}"
  end
  execute "go install #{c[:name]}" do
    command "#{CMD} install #{c[:cmd]}"
    user node[:install_user]
    not_if "type #{c[:name]}"
  end
end

[
  'github.com/mdempsky/gocode',
  'github.com/k0kubun/pp'
].each do |pkg|
  execute "go get #{pkg}" do
    command "#{CMD} get -u #{pkg}"
    user node[:install_user]
    not_if "test -d #{ENV['GOPATH']}/src/#{pkg}"
  end
end
