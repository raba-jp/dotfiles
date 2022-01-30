{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.dotfiles.game;
in
{
  options.dotfiles.game = {
    enable = mkEnableOption "if you play game";
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;
  };
}
