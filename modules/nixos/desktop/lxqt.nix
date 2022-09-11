{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.desktop.lxqt;
in {
  options.dotfiles.desktop.lxqt = {
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
