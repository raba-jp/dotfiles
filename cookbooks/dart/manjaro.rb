flutter_version = "1.17.1"

execute "curl -Lo /tmp/flutter.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_#{flutter_version}-stable.tar.xz" do
  user node["user"]
  not_if "test -e #{node["home"]}/.local/share/flutter-#{flutter_version}/bin/flutter"
end

execute "tar xf /tmp/flutter.tar.xz -C /tmp" do
  user node["user"]
  not_if "test -e #{node["home"]}/.local/share/flutter-#{flutter_version}/bin/flutter"
end

execute "mv /tmp/flutter #{node["home"]}/.local/share/flutter-#{flutter_version}" do
  user node["user"]
  not_if "test -e #{node["home"]}/.local/share/flutter-#{flutter_version}/bin/flutter"
end

link "#{node["home"]}/.local/share/flutter" do
  user node["user"]
  to "#{node["home"]}/.local/share/flutter-#{flutter_version}"
  not_if "test -e #{node["home"]}/.local/share/flutter/bin/flutter"
end
