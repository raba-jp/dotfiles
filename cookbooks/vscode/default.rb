
if manjaro_linux?
  pkg "glibc"
  pkg "libcanberra"
  pkg "gvfs"
  pkg "visual-studio-code-bin"

  directory "#{node["home"]}/.config/Code/User" do
    user node["user"]
  end

  [
    "Code/User/settings.json",
    "Code/User/keybindings.json",
    "Code/User/locale.json",
    "Code/User/projects.json"
  ].each do |item|
    ln item do
      user node["user"]
    end
  end
end

if darwin?
  link "#{node["home"]}/Library/Application\ Support/Code/User/settings.json" do
    user node["user"]
    to File.expand_path("../../../config/Code/User/settings.json", __FILE__)
  end

  link "#{node["home"]}/Library/Application\ Support/Code/User/keybindings.json" do
    user node["user"]
    to File.expand_path("../../../config/Code/User/keybindings.json", __FILE__)
  end

  link "#{node["home"]}/Library/Application\ Support/Code/User/locale.json" do
    user node["user"]
    to File.expand_path("../../../config/Code/User/locale.json", __FILE__)
  end

  link "#{node["home"]}/Library/Application\ Support/Code/User/projects.json" do
    user node["user"]
    to File.expand_path("../../../config/Code/User/projects.json", __FILE__)
  end
end

%w(
  2gua.rainbow-brackets
  alefragnani.project-manager
  apollographql.vscode-apollo
  auchenberg.vscode-browser-preview
  BazelBuild.vscode-bazel
  castwide.solargraph
  Dart-Code.dart-code
  Dart-Code.flutter
  dbaeumer.vscode-eslint
  eamodio.gitlens
  esbenp.prettier-vscode
  gerane.Theme-Solarized-dark
  GitHub.vscode-pull-request-github
  googlecloudtools.cloudcode
  jnbt.vscode-rufo
  keyring.Lua
  mauve.terraform
  misogi.ruby-rubocop
  ms-azuretools.vscode-docker
  MS-CEINTL.vscode-language-pack-ja
  ms-kubernetes-tools.vscode-kubernetes-tools
  ms-python.python
  ms-vscode-remote.remote-containers
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-ssh-edit
  ms-vscode-remote.remote-ssh-explorer
  ms-vscode-remote.remote-wsl
  ms-vscode-remote.vscode-remote-extensionpack
  ms-vscode.Go
  ms-vsliveshare.vsliveshare
  PKief.material-icon-theme
  rebornix.ruby
  redhat.vscode-yaml
  rust-lang.rust
  sianglim.slim
  TabNine.tabnine-vscode
  VisualStudioExptTeam.vscodeintellicode
  vscodevim.vim
  wingrunr21.vscode-ruby
  zxh404.vscode-proto3
).each do |item|
  execute "code --install-extension '#{item}'" do
    not_if "code --list-extensions | grep '#{item}'"
    user node["user"]
  end
end
