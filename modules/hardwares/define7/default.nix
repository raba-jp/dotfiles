{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "define7";
}
