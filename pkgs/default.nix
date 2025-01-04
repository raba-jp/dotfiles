{pkgs ? null}: {
  stubin = pkgs.callPackage ./stubin.nix {};
}
