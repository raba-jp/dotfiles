{ config, lib, pkgs, modulesPath, ... }:
let
  rtl8723du = config.boot.kernelPackages.callPackage ./driver.nix { };
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_5_15;
  boot.extraModulePackages = [ rtl8723du ];

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce [
    "btrfs"
    "reiserfs"
    "vfat"
    "f2fs"
    "xfs"
    "ntfs"
    "cifs"
  ];
}
