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

    services.xserver.videoDrivers = [ "amdgpu" ];

    environment.systemPackages = with pkgs; [
      glxinfo
      libva-utils
      vulkan-tools
    ];

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ amdvlk ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
  };
}
