{ inputs, stable, ... }: {
  nixpkgs.overlays = [
    (import ./cica.nix)
    (import ./tilt.nix)
    # (import ./beautifulsoup4.nix)
    (import ./factorio.nix)
    (final: prev: { stable = import stable { system = prev.system; }; })
    # (final: prev: rec { kitty = prev.stable.kitty; })
  ];
}
