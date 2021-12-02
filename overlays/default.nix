{ inputs, stable, ... }: {
  nixpkgs.overlays = [
    (import ./cica.nix)
    (import ./tilt.nix)
    (final: prev: { stable = import stable { system = prev.system; }; })
  ];
}
