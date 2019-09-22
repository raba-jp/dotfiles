# frozen_string_literal: true

%w[
  rails-completion
  gem-completion
  rake-completion
  reattach-to-user-namespace
  git
  gnu-sed
  ripgrep
  bash-completion
  go
  hub
  ruby-completion
  brew-cask-completion
  bundler-completion
  stern
  circleci
  clang-format
  terraform
  neovim
  clojure
  jq
  nkf
  kubectx
  tig
  direnv
  kubernetes-cli
  tmux
  dive
  kubernetes-helm
  openssl
  docker-completion
  less
  docker-compose-completion
  tree
  peco
  exa
  pip-completion
  fd
  pipenv
  fish
  wget
  python
  python@2
].each do |pkg|
  package pkg do
    action :install
    only_if "brew info #{pkg} | grep -qi 'Not Installed'"
  end
end
