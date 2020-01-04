execute "bash -c 'curl https://sh.rustup.rs -sSf | sh -s -- -y" do
  user node["user"]
  not_if "type cargo"
end
