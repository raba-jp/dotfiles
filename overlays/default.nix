inputs: final: prev:

with prev.lib;

(foldl' (flip extends) (_: prev)
[
  (import ./stable.nix)
  (import ./cica.nix)
  (import ./stack.nix)
  (import ./tilt.nix)
  ((import ./vim.nix) inputs)
]
) final
