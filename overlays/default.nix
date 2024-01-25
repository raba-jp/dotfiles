{
  additions = final: _prev: import ../pkgs {pkgs = final;};
  modifications = final: prev:
    with prev.lib;
      (
        foldl' (flip extends) (_: prev)
        []
      )
      final;
}
