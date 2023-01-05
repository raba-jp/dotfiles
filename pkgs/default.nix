{pkgs ? null}: {
  cljstyle = pkgs.callPackage ./cljstyle.nix {};
  ecspresso = pkgs.callPackage ./ecspresso.nix {};
  tfmigrate = pkgs.callPackage ./tfmigrate.nix {};
  udev-gothic = pkgs.callPackage ./udev-gothic.nix {};
  udev-gothic-nf = pkgs.callPackage ./udev-gothic-nf.nix {};
}
