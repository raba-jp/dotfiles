manjaro_pkg "docker"
manjaro_pkg "docker-compose"
manjaro_pkg "docker-machine"
manjaro_pkg "libvirt"
manjaro_pkg "qemu"
manjaro_pkg "ebtables"
manjaro_pkg "dnsmasq"
manjaro_pkg "docker-machine-driver-kvm2"

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
