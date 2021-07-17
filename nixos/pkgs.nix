{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    chromium
    git
    gnome.gnome-tweaks
    libnotify
    vim
    wget
    nixos-generators
];
}
