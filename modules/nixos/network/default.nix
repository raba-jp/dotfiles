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
    hostName = mkOption {
      type = types.str;
    };
  };

  config = {
    networking = {
      inherit (cfg) hostName;

      networkmanager.enable = true;
      useDHCP = false;
    };
  };
}
