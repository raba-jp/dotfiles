directory "/etc/docker"

if arch_linux?
  remote_file "/etc/docker/daemon.json" do
    user "root"
    owner "root"
    group "root"
    mode "644"
    source "files/daemon.json"
  end
  
  remote_file "/etc/subuid" do
    user "root"
    owner "root"
    group "root"
    mode "644"
    source "files/subuid"
  end
  
  remote_file "/etc/subgid" do
    user "root"
    owner "root"
    group "root"
    mode "644"
    source "files/subgid"
  end

  pkg "docker"
  pkg "docker-compose"
  pkg "docker-machine"
  pkg "libvirt"
  pkg "qemu"
  pkg "ebtables"
  pkg "dnsmasq"
  pkg "docker-machine-driver-kvm2"

  ["docker", "libvirt"].each do |g|
    group g do
      user "root"
      action :create
    end

    execute "usermod sakuraba -aG #{g}" do
      user "root"
      only_if "id sakuraba"
      not_if "groups sakuraba | grep #{g}"
    end
  end

  service "docker.service" do
    user "root"
    action [:reload, :restart, :enable]
  end

  service "libvirtd.service" do
    user "root"
    action [:reload, :restart, :enable]
  end

  service "virtlogd.service" do
    user "root"
    action [:reload, :restart, :enable]
  end
end

if darwin?
  pkg "docker"
end
