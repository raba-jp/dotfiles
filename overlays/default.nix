final: prev:
with prev.lib;
  (
    foldl' (flip extends) (_: prev)
    [
      (import ./cica.nix)
      (import ./udev-gothic.nix)
      (import ./popshell.nix)
      (import ./vim-startuptime.nix)
      (import ./nordic.nix)
    ]
  )
  final
