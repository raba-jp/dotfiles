%w(
  2gua.rainbow-brackets
  alefragnani.project-manager
  apollographql.vscode-apollo
  auchenberg.vscode-browser-preview
  BazelBuild.vscode-bazel
  castwide.solargraph
  dbaeumer.vscode-eslint
  eamodio.gitlens
  esbenp.prettier-vscode
  gerane.Theme-Solarized-dark
  GitHub.vscode-pull-request-github
  googlecloudtools.cloudcode
  keyring.Lua
  mauve.terraform
  ms-azuretools.vscode-docker
  MS-CEINTL.vscode-language-pack-ja
  ms-kubernetes-tools.vscode-kubernetes-tools
  ms-vscode-remote.remote-containers
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-ssh-edit
  ms-vscode-remote.remote-ssh-explorer
  ms-vscode-remote.vscode-remote-extensionpack
  ms-vscode.Go
  ms-vsliveshare.vsliveshare
  PKief.material-icon-theme
  redhat.vscode-yaml
  rust-lang.rust
  VisualStudioExptTeam.vscodeintellicode
  vscodevim.vim
  zxh404.vscode-proto3
).each do |item|
  execute "code --install-extension '#{item}'" do
    not_if "code --list-extensions | grep '#{item}'"
    user node["user"]
  end
end
