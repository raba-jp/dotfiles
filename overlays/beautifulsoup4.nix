final: prev:
let lib = prev.lib;
in rec {
  python39 = prev.python39.override {
    packageOverrides = self: super: {
      beautifulsoup4 = super.beautifulsoup4.overrideAttrs (old: {
        propagatedBuildInputs = lib.remove super.lxml old.propagatedBuildInputs;
      });
    };
  };
  python39Packages = python39.pkgs;
}
