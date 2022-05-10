{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotfiles.lxqt;
in {
  options.dotfiles.lxqt = {
    enable = mkEnableOption "if you use LXQt";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      displayManager.sddm.enable = true;

      desktopManager.lxqt.enable = true;
    };
  };
}
