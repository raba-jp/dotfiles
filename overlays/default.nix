{ inputs, stable, ... }: 
let
  zinit = import ./zinit.nix;
in {
  nixpkgs.overlays = [
    (final: prev: {
      cica = prev.callPackage (import ./fonts/cica.nix) { };
    })
    (final: prev: { stable = import stable { system = prev.system; }; })
    (final: prev: rec { kitty = prev.stable.kitty; })
    (self: super:
      let lib = super.lib;
      in rec {
        python39 = super.python39.override {
          packageOverrides = self: super: {
            beautifulsoup4 = super.beautifulsoup4.overrideAttrs (old: {
              propagatedBuildInputs =
                lib.remove super.lxml old.propagatedBuildInputs;
            });
          };
        };
        python39Packages = python39.pkgs;
      })
    zinit
  ];
}
