{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dotfiles.physical;
in
{
  options.dotfiles.physical = {
    enable = mkEnableOption "if host is physical environment";
    timezone = mkOption {
      type = types.str;
      default = "Asia/Tokyo";
    };
    locale = mkOption {
      type = types.str;
      default = "ja_JP.UTF-8";
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "auto";
      };

      efi.canTouchEfiVariables = true;
    };

    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.locale;

    networking = {
      networkmanager.enable = true;
      useDHCP = false;
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    fonts = {
      fontDir.enable = true;

      fonts = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        cica
        jetbrains-mono
        udev-gothic
        udev-gothic-nf
      ];

      fontconfig.defaultFonts = {
        serif = [ "Noto Sans CJK JP" ];
        sansSerif = [ "Noto Sans Mono CJK JP" ];
      };
    };

    console.useXkbConfig = true;

    services.openssh.enable = true;
    programs.gnupg.agent.enable = true;

    systemd.services.cachix-agent = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      path = [ config.nix.package ];
      reloadIfChanged = true;
      serviceConfig = {
        Restart = "on-failure";
        Environment = "USER=root";
        EnvironmentFile = config.sops.secrets."cachix-agent-token".path;
        ExecStart = "${pkgs.cachix}/bin/cachix deploy agent ${config.networking.hostName}";
      };
    };
  };
}