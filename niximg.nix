{ config, pkgs, ... }:

{
  imports = [
    ./modules/nixos/nixpkgs.nix
    ./modules/nixos/boot.nix
    ./modules/nixos/networking.nix
    ./modules/nixos/localize.nix
    ./modules/nixos/sound.nix
    ./modules/nixos/gnome.nix
    ./modules/nixos/pkgs.nix
    ./modules/nixos/virtualization.nix
  ];

  networking.hostName = "niximg";

  users.users.nixos = {
    isNormalUser = true;
  };

  system = {
    stateVersion = "21.05";
  };
}

