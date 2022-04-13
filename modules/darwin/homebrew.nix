{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dotfiles.homebrew;
in
{
  options.dotfiles.homebrew = {
    enable = mkEnableOption "if you use homebrew";

    cleanup = mkOption {
      type = types.str;
      default = "uninstall";
    };

    taps = mkOption {
      type = with types; listOf str;
      default = [ ];
    };

    brews = mkOption {
      type = with types; listOf str;
      default = [ ];
    };

    casks = mkOption {
      type = with types; listOf str;
      default = [ ];
    };

    masApps = mkOption {
      type = with types; listOf str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = cfg.enable;
      autoUpdate = true;
      cleanup = cfg.cleanup;
      global = {
        brewfile = true;
        noLock = true;
      };

      taps = cfg.taps;
      brews = cfg.brews;
      casks = cfg.casks;
      masApps = cfg.masApps;
    };
  };
}
