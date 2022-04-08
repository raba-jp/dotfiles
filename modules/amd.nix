{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.dotfiles.amd;
in
{
  options.dotfiles.amd = {
    enable = mkEnableOption "if you use AMD GPU";
  };

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];

    services.xserver.videoDrivers = [ "amdgpu" "radeon" "modesetting" "fbdev" ];

    environment.systemPackages = with pkgs; [
      glxinfo
    ];

    hardware.opengl.driSupport = true;
  };
}
