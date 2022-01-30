{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.dotfiles.factorioServer;
in
{
  options.dotfiles.factorioServer = {
    enable = mkEnableOption "if you start factorio server";
  };

  config = mkIf cfg.enable {
    services.factorio = {
      enable = true;
      public = false;
    };

    networking = {
      firewall = {
        allowedTCPPorts = [ 34197 ];
        allowedUDPPorts = [ 34197 ];
      };
    };
  };
}
