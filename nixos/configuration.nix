# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    <home-manager/nixos>
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/boot.nix
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/networking.nix
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/localize.nix
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/sound.nix
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/gnome.nix
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/users.nix
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/pkgs.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = import /home/sakuraba/ghq/github.com/raba-jp/dotfiles/overlays;
  };

  nix = {
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 31d";
    };
    trustedUsers = [ "root" "sakuraba" ];
  };

  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.05";
  };
}

