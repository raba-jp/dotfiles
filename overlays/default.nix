final: prev:
with prev.lib;
(foldl' (flip extends) (_: prev)
  [
    (import ./cica.nix)
    (import ./udev-gothic.nix)
    (import ./popshell.nix)
    (final: prev: { sidekick = ((prev.callPackage ./sidekick.nix) { }); })
    (import ./vim-startuptime.nix)
  ]
) final
