{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.services.nextdns;
in {
  options.dotfiles.services.nextdns = {
    enable = mkEnableOption "whether enable NextDNS";
    filePath = mkOption {
      type = types.path;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    services = {
      nextdns = {
        enable = true;
        arguments = ["-config-file" cfg.filePath];
      };
    };
  };
}
