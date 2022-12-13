{lib, ...}: {
  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = lib.mkDefault "ja_JP.UTF-8";
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };
}
