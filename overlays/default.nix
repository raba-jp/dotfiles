inputs: final: prev:

with prev.lib;

(foldl' (flip extends) (_: prev)
  [
    (import ./cica.nix)
    # (import ./contour.nix)
    ((import ./vim.nix) inputs)
  ]
) final
