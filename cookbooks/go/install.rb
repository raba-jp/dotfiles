# frozen_string_literal: true

include_recipe './dependency' if node[:go][:install_dependency]

directory node[:go][:root_path] do
  action :create
end

if node[:platform] == 'darwin'
  execute 'download tar' do
    command "wget -O go#{node[:go][:version]}.tar.gz https://dl.google.com/go/go#{node[:go][:version]}.darwin-amd64.tar.gz"
    user node[:go][:user]
    not_if "test -x #{node[:go][:root_path]}/bin/go"
  end
else
  execute 'download tar' do
    command "wget -O go#{node[:go][:version]}.tar.gz https://dl.google.com/go/go#{node[:go][:version]}.linux-amd64.tar.gz"
    user node[:go][:user]
    not_if "test -x #{node[:go][:root_path]}/bin/go"
  end
end

execute 'untar' do
  command "tar -C #{node[:go][:root_path]} -xzf go#{node[:go][:version]}.tar.gz"
  user node[:go][:user]
  not_if "test -x #{node[:go][:root_path]}/bin/go"
end

execute 'delete tar' do
  command "rm -f go#{node[:go][:version]}.tar.gz"
  user node[:go][:user]
  only_if "test -f go#{node[:go][:version]}.tar.gz"
end

if node[:go][:create_symlink]
  %w[go gofmt].each do |cmd|
    link "/usr/local/bin/#{cmd}" do
      to "#{node[:go][:root_path]}/bin/#{cmd}"
      user node[:go][:user]
      not_if "test -x #{node[:go][:root_path]}/bin/#{cmd}"
    end
  end
end
