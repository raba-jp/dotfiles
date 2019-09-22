# frozen_string_literal: true

execute 'install rustup' do
  command 'curl https://sh.rustup.rs -sSf | sh'
  not_if 'type rustup'
end
