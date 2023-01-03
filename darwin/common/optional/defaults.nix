{...}: {
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

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
        "com.apple.trackpad.scaling" = 3.0;
        # ダークモード
        AppleInterfaceStyle = "Dark";
      };

      dock = {
        # dockを自動的に表示/非表示
        autohide = true;
        show-recents = false;
        # 最新の使用状況に基づいて操作スペースを自動的に並べ替える
        mru-spaces = false;
        # 起動済みのアプリケーションにインジケータを表示
        show-process-indicators = true;
      };

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
