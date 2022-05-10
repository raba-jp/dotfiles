{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.nextdns;
in {
  options.dotfiles.nextdns = {
    enable = mkEnableOption "if you use NextDNS";
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
