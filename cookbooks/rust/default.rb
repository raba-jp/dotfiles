# frozen_string_literal: true

execute 'download setup script' do
  command <<-SCRIPT
    wget -O rustup.sh https://sh.rustup.rs
    chmod +x ./rustup.sh
    ./rustup.sh -y
    rm -rf ./rustup.sh
  SCRIPT
  not_if 'type rustup'
end