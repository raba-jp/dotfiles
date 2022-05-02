{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dotfiles.gnome;
in
{
  options.dotfiles.gnome = {
    enable = mkEnableOption "if you use Gnome Desktop";
    autoLogin = {
      enable = mkEnableOption "Automatically log in as autoLogin.user.";
      username = mkOption {
        type = types.str;
        description = "User to be used for the automatic login.";
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;

        displayManager = {
          gdm = {
            enable = true;
          };

          autoLogin = {
            enable = cfg.autoLogin.enable;
            user = cfg.autoLogin.user;
          };
        };

        desktopManager.gnome.enable = true;
      };

      gnome.chrome-gnome-shell.enable = true;
    };

    programs.dconf.enable = true;

    environment = {
      gnome.excludePackages = with pkgs; [
        gnome.cheese
        gnome-photos
        gnome.gnome-music
        gnome.gnome-terminal
        gnome.gedit
        gnome.epiphany
        evince
        gnome.gnome-characters
        gnome.totem
        gnome.tali
        gnome.iagno
        gnome.hitori
        gnome.atomix
        gnome-tour
        gnome.geary
      ];

      systemPackages = [ pkgs.gnome.gnome-tweaks ];
    };
  };

}
