{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.homebrew;
in {
  options.dotfiles.homebrew = {
    enable = mkEnableOption "if you use homebrew";

    cleanup = mkOption {
      type = types.str;
      default = "uninstall";
    };

    taps = mkOption {
      type = with types; listOf str;
      default = [];
    };

    brews = mkOption {
      type = with types; listOf str;
      default = [];
    };

    casks = mkOption {
      type = with types; listOf str;
      default = [];
    };

    masApps = mkOption {
      type = with types; attrsOf ints.positive;
      default = {};
    };
  };

  config = mkIf cfg.enable {
    homebrew = {
      inherit (cfg) enable;
      autoUpdate = true;
      inherit (cfg) cleanup;
      global = {
        brewfile = true;
        noLock = true;
      };

      inherit (cfg) taps;
      inherit (cfg) brews;
      inherit (cfg) casks;
      inherit (cfg) masApps;
    };
  };
}
