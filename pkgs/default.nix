{pkgs ? null}: {
  udev-gothic = pkgs.callPackage ./udev-gothic.nix {};
  udev-gothic-nf = pkgs.callPackage ./udev-gothic-nf.nix {};
}
