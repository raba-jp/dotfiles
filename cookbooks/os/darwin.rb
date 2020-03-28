[
  { domain: "NSGlobalDomain", key: "NSTextShowsControlCharacters", type: "bool", value: "true" }, # ASCII制御文字を表示する
  { domain: "NSGlobalDomain", key: "NSQuitAlwaysKeepsWindows", type: "bool", value: "false" }, # アプリケーションを終了して再度開くときにウィンドウを復元しない
  { domain: "NSGlobalDomain", key: "NSDisableAutomaticTermination", type: "bool", value: "false" }, # automatic termination機能の無効化
  { domain: "NSGlobalDomain", key: "com.apple.swipescrolldirection", type: "bool", value: "true" }, # スクロールの方向 ナチュラル
  { domain: "NSGlobalDomain", key: "KeyRepeat", type: "int", value: "2" }, # キーリピートの速さ 最速
  { domain: "NSGlobalDomain", key: "InitialKeyRepeat", type: "int", value: "15" },
  { domain: "NSGlobalDomain", key: "AppleShowAllExtensions", type: "bool", value: "true" }, # すべてのファイルの拡張子を表示
  { domain: "com.apple.BazelServices", key: "kDim", type: "bool", value: "true" }, # 環境光が暗い場合にキーボードの輝度を調整
  { domain: "com.apple.BazelServices", key: "kDimTime", type: "int", value: "15" }, # 発行した状態で待機する時間 15秒
  { domain: "com.apple.screensaver", key: "askForPassword", type: "int", value: "1" }, # スクリーンセーバー解除時にパスワードを要求する
  { domain: "com.apple.screensaver", key: "askForPasswordDelay", type: "float", value: "0" }, # スクリーンセーバーに入ってから何秒後からパスワードを要求するか 0秒
  { domain: "com.apple.screencapture", key: "location", type: "string", value: "$HOME/Desktop" }, # スクリーンショットの出力先
  { domain: "com.apple.screencapture", key: "disable-shadow", type: "bool", value: "true" }, # スクリーンショットの影付き効果なし
  { domain: "com.apple.dashboard", key: "mcx-disabled", type: "bool", value: "true" }, # Dashboardを無効にする
  { domain: "com.apple.dock", key: "mru-spaces", type: "bool", value: "false" }, # 使用状況に基づいてスペースを並び替えないようにする
  { domain: "com.apple.CrashReporter", key: "DialogType", type: "string", value: "none" }, # クラッシュリポーターダイアログを表示しない
  { domain: "com.apple.helpviewer", key: "DevMode", type: "bool", value: "true" }, # ヘルプを常時前面表示しない
  { domain: "com.apple.driver.AppleBluetoothMultitouch.trackpad", key: "Clicking", type: "int", value: "1" }, # トラックパッドをタップ = 常時クリック
  { domain: "com.apple.LaunchServices", key: "LSQuarantine", type: "bool", value: "false" }, # ... 開いてもよろしいですかを表示しない
].each do |item|
  execute "defaults write #{item[:domain]} #{item[:key]} -#{item[:type]} #{item[:value]}" do
  end
end
