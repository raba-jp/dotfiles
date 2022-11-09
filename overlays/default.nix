final: prev:
with prev.lib;
  (
    foldl' (flip extends) (_: prev)
    [
      (import ./udev-gothic.nix)
      (import ./popshell.nix)
      (import ./nordic.nix)
      (import ./cljstyle.nix)
      (import ./heptabase.nix)
      (import ./ecspresso.nix)
      (import ./tfmigrate.nix)
      (_final: prev: {sidekick = (prev.callPackage ./sidekick.nix) {};})
    ]
  )
  final
