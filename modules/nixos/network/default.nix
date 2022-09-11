{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.network;
in {
  options.dotfiles.network = {
    enable = mkDefaultOption "whether enable wifi";
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      useDHCP = false;
      firewall = {
        allowedTCPPorts = [8080];
        allowedUDPPorts = [8080];
      };
    };
  };
}
