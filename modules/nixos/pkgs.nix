{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    chromium
    gnome.gnome-tweaks
    libnotify
    wget
    nixos-generators
  ];
}
