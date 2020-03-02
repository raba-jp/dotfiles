execute `bash -c 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y` do
  user node["user"]
  not_if "type cargo"
end
