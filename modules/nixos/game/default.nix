{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.game;
in {
  options.dotfiles.game = {
    enable = mkEnableOption "if you play game";

    factorio = {
      server = {
        enable = mkEnableOption "if you run factorio server";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;

    services.factorio = mkIf cfg.factorio.server.enable {
      enable = true;
      public = false;
    };

    networking = mkIf cfg.factorio.server.enable {
      firewall = {
        allowedTCPPorts = [34197];
        allowedUDPPorts = [34197];
      };
    };
  };
}
