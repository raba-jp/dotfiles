{ lib, pkgs, ... }: {
  imports = [
    ./mako.nix
    ./swayidle.nix
    ./swaylock.nix
    ./clipboard.nix
    ./waybar.nix
  ];
}
