# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ../../modules/nixos/nix.nix
    ../../modules/nixos/nixpkgs.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/localize.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/pkgs.nix
    ../../modules/nixos/virtualization.nix
  ];

  networking.hostName = "define7-nixos";


  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.05";
  };
}

