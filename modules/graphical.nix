{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.dotfiles.graphical;
in
{
  options.dotfiles.graphical = {
    enable = mkEnableOption "if you have display";
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_zen;

    services = {
      xserver = {
        enable = true;

        layout = "us";
        xkbOptions = "ctrl:nocaps";
        libinput.enable = true;

        displayManager.gdm = {
          enable = true;
          wayland = true;
          # nvidiaWayland = false;
        };

        desktopManager.gnome.enable = true;
      };


      gnome.chrome-gnome-shell.enable = true;
    };

    i18n = {
      inputMethod = {
        enabled = "fcitx";
        fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
        # fcitx5.addons = with pkgs; [ fcitx5-mozc ];
      };
    };

    networking = {
      networkmanager.enable = true;
      useDHCP = false;
    };

    sound.enable = true;
    hardware = {
      opengl.enable = true;

      pulseaudio.enable = true;
    };

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs;
      [
        chromium
        gnome.gnome-tweaks
      ];
  };
}
