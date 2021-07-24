{ config, pkgs, ... }: {
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
}
