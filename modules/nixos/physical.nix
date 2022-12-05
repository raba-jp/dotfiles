{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotfiles.physical;
in {
  options.dotfiles.physical = {
    enable = mkEnableOption "if host is physical environment";
    kernelPackages = mkOption {
      type = types.unspecified;
      default = pkgs.linuxPackages_latest;
    };

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
    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.locale;

    # Sound
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    fonts = {
      fontDir.enable = true;

      fonts = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        jetbrains-mono
        udev-gothic
        udev-gothic-nf
      ];

      fontconfig.defaultFonts = {
        serif = ["Noto Sans CJK JP"];
        sansSerif = ["Noto Sans Mono CJK JP"];
      };
    };

    console.useXkbConfig = true;

    services = {
      udev.extraRules = ''
        KERNEL=="hidraw*", ATTRS{idVendor}=="bb01", MODE="0664", GROUP="users"
        KERNEL=="hidraw*", ATTRS{idVendor}=="4653", MODE="0664", GROUP="users"
      '';

      openssh.enable = true;

      greetd = {
        enable = false;
        restart = false;

        settings = {
          default_session = {
            command = "${lib.makeBinPath [pkgs.greetd.tuigreet]}/tuigreet --time --cmd sway";
            user = "greeter";
          };
        };
      };
    };
    programs = {
      gnupg.agent.enable = true;
    };

    environment.systemPackages = with pkgs; [
      appimagekit
      appimage-run
      google-chrome
      obsidian
      logseq
      vscode
      papirus-icon-theme
      nordic
      materia-theme
      papirus-icon-theme
      nordzy-cursor-theme
      gnomeExtensions.pop-shell
      gparted
      flutter
      kube3d
      xclip
      dconf2nix
      libnotify
      lm_sensors
      # heptabase
      sidekick
      flatpak
      lutris
      bottles
      brave
      slack
    ];
  };
}
