{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "xps13";

  services = { power-profiles-daemon.enable = true; };

  environment.systemPackages = with pkgs; [ lm_sensors ];
}

