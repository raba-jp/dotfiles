{
  additions = final: prev: import ../pkgs {pkgs = final;};
  modifications = final: prev:
    with prev.lib;
      (
        foldl' (flip extends) (_: prev)
        [
          (import ./brave.nix)
        ]
      )
      final;
}
