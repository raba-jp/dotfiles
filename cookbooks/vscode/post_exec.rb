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
