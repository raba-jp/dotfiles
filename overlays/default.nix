inputs: final: prev:

with prev.lib;

(foldl' (flip extends) (_: prev)
  [
    (import ./cica.nix)
    ((import ./vim.nix) inputs)
  ]
) final
