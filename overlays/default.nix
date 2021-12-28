final: prev:

with prev.lib;

(foldl' (flip extends) (_: prev)
  (map import [ ./stable.nix ./cica.nix ./stack.nix ./tilt.nix ./vim.nix ])) final
