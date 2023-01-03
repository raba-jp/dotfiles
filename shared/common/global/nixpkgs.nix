{outputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = builtins.attrValues outputs.overlays;
  };
}
