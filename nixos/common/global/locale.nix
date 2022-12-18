{
  lib,
  pkgs,
  ...
}: {
  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = lib.mkDefault "ja_JP.UTF-8";
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
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
}
