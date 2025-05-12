{outputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };

    overlays = builtins.attrValues outputs.overlays;
  };
}
