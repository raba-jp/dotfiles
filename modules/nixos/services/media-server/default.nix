{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.services.mediaServer;
in {
  options.dotfiles.services.mediaServer = {
    enable = mkEnableOption "whether enable media server";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
