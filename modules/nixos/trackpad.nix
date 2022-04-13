{config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dotfiles.trackpad;
in 
  {
    options.dotfiles.trackpad = {
      enable = mkEnableOption "if you have trackpad";
    };

    config = mkIf cfg.enable {
      services.xserver.libinput = {
        enable = true;
      };
    };
  }
