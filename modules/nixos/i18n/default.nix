{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.i18n;
in {
  options.dotfiles.i18n = {
    timezone = mkOption {
      type = types.str;
      default = "Asia/Tokyo";
    };

    locale = mkOption {
      type = types.str;
      default = "ja_JP.UTF-8";
    };
  };

  config = {
    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.locale;

    i18n = {
      inputMethod = {
        enabled = "fcitx";
        fcitx.engines = with pkgs.fcitx-engines; [mozc];
        # fcitx5.addons = with pkgs; [ fcitx5-mozc ];
      };
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
  };
}
