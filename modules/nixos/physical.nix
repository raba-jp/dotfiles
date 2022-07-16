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

    boot.loader.useDefault = mkEnableOption "if host uses default boot loader configuration";

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
    boot = {
      inherit (cfg) kernelPackages;

      loader = mkIf cfg.boot.loader.useDefault {
        systemd-boot = {
          enable = true;
          editor = false;
          consoleMode = "auto";
        };

        efi.canTouchEfiVariables = true;
      };
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

      cachix-agent = mkIf (builtins.hasAttr "cachixAgentToken" config.sops.secrets) {
        enable = true;
        credentialsFile = config.sops.secrets.cachixAgentToken.path;
      };
    };
    programs.gnupg.agent.enable = true;

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
      heptabase
    ];
  };
}
