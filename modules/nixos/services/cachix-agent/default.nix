{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotfiles.services.cachix-agent;
in {
  options.dotfiles.services.cachix-agent = {
    enable = mkEnableOption "whether enable Cachix agent";
  };

  config = mkIf cfg.enable {
    services.cachix-agent = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [cachix];
  };
}
