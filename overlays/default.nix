{ inputs, stable, ... }: {
  nixpkgs.overlays = [
    (final: prev: { cica = prev.callPackage (import ./fonts/cica.nix) { }; })
    (final: prev: { stable = import stable { system = prev.system; }; })
    (final: prev: rec { kitty = prev.stable.kitty; })
  ];
}
