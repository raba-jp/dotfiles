{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotfiles.services.cachixAgent;
in {
  options.dotfiles.services.cachixAgent = {
    enable = mkEnableOption "whether enable Cachix agent";
  };

  config = mkIf cfg.enable {
    services.cachix-agent = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [cachix];
  };
}
