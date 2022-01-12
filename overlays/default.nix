inputs: final: prev:

with prev.lib;

(foldl' (flip extends) (_: prev)
  [
    (import ./stable.nix)
    (import ./zsh.nix)
    (import ./cica.nix)
    (import ./stack.nix)
    (import ./tilt.nix)
    (import ./kitty.nix)
    ((import ./vim.nix) inputs)
    ((import ./cachix.nix) inputs)
  ]
) final
