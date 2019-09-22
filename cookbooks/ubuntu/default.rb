# frozen_string_literal: true

%w[fish
   git
   vim
   neovim
   tmux
   openssl
   python
   python3
   clojure
].each do |pkg|
  package(pkg)
end

%w[code].each do |pkg|
  execute("snap install #{pkg}")
end