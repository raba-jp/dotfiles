# frozen_string_literal: true

%w[fish
   git
   vim
   neovim
   tmux
   openssl
   python
   python3
   clojure].each do |pkg|
  package(pkg)
end

[{ pkg: 'code', opt: '--classic' }].each do |input|
  execute("snap install #{input[:opt]} #{input[:pkg]}")
end
