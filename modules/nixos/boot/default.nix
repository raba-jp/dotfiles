{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.boot;
in {
  options.dotfiles.boot = {
    kernelPackages = mkOption {
      type = types.unspecified;
      default = pkgs.linuxPackages_latest;
    };
    blacklistedKernelModules = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };

  config = {
    boot = {
      inherit (cfg) kernelPackages;

      loader = {
        systemd-boot = {
          enable = true;
          editor = false;
          consoleMode = "auto";
        };

        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };
    };
  };
}
