# frozen_string_literal: true

include_recipe './dependency' if node[:go][:install_dependency]

directory node[:go][:root_path] do
  action :create
end

if node[:platform] == 'darwin'
  http_request 'go' do
    path "/tmp/go#{node[:go][:version]}.tar.gz"
    url "https://dl.google.com/go/go#{node[:go][:version]}.darwin-amd64.tar.gz"
    not_if "test -e /tmp/go#{node[:go][:version]}.tar.gz"
  end
else
  http_request 'go' do
    path "/tmp/go#{node[:go][:version]}.tar.gz"
    url "https://dl.google.com/go/go#{node[:go][:version]}.linux-amd64.tar.gz"
    not_if "test -e /tmp/go#{node[:go][:version]}.tar.gz"
  end
end

execute "tar -C #{node[:go][:root_path]} -xzf go#{node[:go][:version]}.tar.gz" do
  cwd '/tmp'
  user node[:go][:user]
  not_if "test -e /tmp/go#{node[:go][:version]}.tar.gz"
end

execute 'delete tar' do
  command "rm -f go#{node[:go][:version]}.tar.gz"
  user node[:go][:user]
  not_if "test -f /tmp/go#{node[:go][:version]}.tar.gz"
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
