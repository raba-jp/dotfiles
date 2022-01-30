{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.dotfiles.nvidia;
in
{
  options.dotfiles.nvidia = {
    enable = mkEnableOption "if you use nVidia GPU";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia.nvidiaSettings = true;

    environment.systemPackages = with pkgs; [
      glxinfo
    ];
  };
}
