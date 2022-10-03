{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.mediaServer;
in {
  options.dotfiles.mediaServer = {
    enable = mkEnableOption "whether enable media server";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
