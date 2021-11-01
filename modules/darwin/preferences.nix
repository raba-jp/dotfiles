{ config, pkgs, ... }:

{
  system = {
    defaults = {
      NSGlobalDomain = {
        # ASCII制御文字を表示する
        NSTextShowsControlCharacters = true;
        # automatic termination機能の無効化
        NSDisableAutomaticTermination = false;
        # キーリピートの速さ 最速
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        # 全てのファイルの拡張子を表示
        AppleShowAllExtensions = true;
        # スクロールの方向 ナチュラル
        "com.apple.swipescrolldirection" = true;
        # 音量を変更した時にフィードバックを再生しない
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.trackpad.scaling" = "3";
      };

      dock.show-recents = false;

      finder = {
        # 全ての拡張子を表示する
        AppleShowAllExtensions = true;
        # ファイルの拡張子を変更するとき警告を表示しない
        FXEnableExtensionChangeWarning = false;
      };

      trackpad = {
        Clicking = true;
        FirstClickThreshold = 1;
        SecondClickThreshold = 1;
        TrackpadRightClick = true;
      };
    };
  };
}
