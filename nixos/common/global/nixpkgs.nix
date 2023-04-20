{outputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        "electron-21.4.0"
      ];
    };

    overlays = builtins.attrValues outputs.overlays;
  };
}
