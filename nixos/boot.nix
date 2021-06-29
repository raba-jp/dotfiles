{ config, pkgs, ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    consoleMode = "auto";
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
