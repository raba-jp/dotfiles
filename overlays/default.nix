final: prev:
with prev.lib;
  (
    foldl' (flip extends) (_: prev)
    [
      (import ./udev-gothic.nix)
      (import ./popshell.nix)
      (import ./vim-startuptime.nix)
      (import ./nordic.nix)
      (import ./cljstyle.nix)
    ]
  )
  final
