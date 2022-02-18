{ lib, pkgs, ... }: {
  imports = [ ../shared.nix ];

  environment = {
    pathsToLink = [ "/Applications" ];

    systemPackages = with pkgs; [ vim ];
  };

  programs.zsh.enable = true;

  services = {
    yabai = {
      enable = false;
      package = pkgs.yabai;
      config = {
        layout = "bsp";
        # padding
        top_padding = 30;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;

        window_placement = "second_child";
        window_topmost = "off";
        window_shadow = "off";
        window_opacity = "on";
        active_window_opacity = 1.0;
        normal_window_opacity = 0.7;
        window_border = "on";
        window_border_width = 6;
        active_window_border_color = "0x00000000";
        normal_window_border_color = "0xff555555";
        insert_feedback_color = "0xaad75f5f";
        split_ratio = 0.50;
        auto_balance = "on";
        mouse_modifier = "fn";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_follows_focus = "on";
        focus_follows_mouse = "autoraise";
      };
    };

    skhd = {
      enable = false;
      skhdConfig = ''
        # focus window
        alt - x : yabai -m window --focus recent
        alt - h : yabai -m window --focus west
        alt - j : yabai -m window --focus south
        alt - k : yabai -m window --focus north
        alt - l : yabai -m window --focus east
        alt - z : yabai -m window --focus stack.prev
        alt - c : yabai -m window --focus stack.next

        # swap window
        shift + alt - x : yabai -m window --swap recent
        shift + alt - h : yabai -m window --swap west
        shift + alt - j : yabai -m window --swap south
        shift + alt - k : yabai -m window --swap north
        shift + alt - l : yabai -m window --swap east

        # move window
        shift + cmd - h : yabai -m window --warp west
        shift + cmd - j : yabai -m window --warp south
        shift + cmd - k : yabai -m window --warp north
        shift + cmd - l : yabai -m window --warp east

        # move window
        shift + ctrl - a : yabai -m window --move rel:-20:0
        shift + ctrl - s : yabai -m window --move rel:0:20
        shift + ctrl - w : yabai -m window --move rel:0:-20
        shift + ctrl - d : yabai -m window --move rel:20:0

        # increase window size
        shift + alt - a : yabai -m window --resize left:-20:0
        shift + alt - s : yabai -m window --resize bottom:0:20
        shift + alt - w : yabai -m window --resize top:0:-20
        shift + alt - d : yabai -m window --resize right:20:0

        # decrease window size
        shift + cmd - a : yabai -m window --resize left:20:0
        shift + cmd - s : yabai -m window --resize bottom:0:-20
        shift + cmd - w : yabai -m window --resize top:0:20
        shift + cmd - d : yabai -m window --resize right:-20:0

        # rotate tree
        alt - r : yabai -m space --rotate 90

        # mirror tree y-axis
        alt - y : yabai -m space --mirror y-axis

        # mirror tree x-axis
        alt - x : yabai -m space --mirror x-axis

        # toggle desktop offset
        alt - a : yabai -m space --toggle padding && yabai -m space --toggle gap

        # toggle window fullscreen zoom
        alt - f : yabai -m window --toggle zoom-fullscreen

        # toggle window native fullscreen
        shift + alt - f : yabai -m window --toggle native-fullscreen

        # toggle window split type
        alt - e : yabai -m window --toggle split

        # float / unfloat window and restore position
        # alt - t : yabai -m window --toggle float && /tmp/yabai-restore/$(yabai -m query --windows --window | jq -re '.id').restore 2>/dev/null || true
        alt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
      '';
    };
  };

  nix = {
    allowedUsers = [ "sakuraba" ];
    trustedUsers = [ "sakuraba" ];
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [ cica ];
  };

  homebrew = {
    enable = true;
    autoUpdate = true;
    brewPrefix = "/opt/homebrew/bin";
    cleanup = "uninstall";
    global = {
      brewfile = true;
      noLock = true;
    };

    taps = [
      "bufbuild/buf"
      "buildpacks/tap"
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
      "reviewdog/tap"
      "tilt-dev/tap"
    ];

    casks = [
      "alacritty"
      "appcleaner"
      "bartender"
      "betterdummy"
      "bettertouchtool"
      "bitwarden"
      "deepl"
      "discord"
      "font-hackgen"
      "font-myrica"
      "google-chrome"
      "hammerspoon"
      "hyperswitch"
      "obsidian"
      "osxfuse"
      "qlmarkdown"
      "quicklook-csv"
      "raycast"
      # "slack"
      "stack-stack"
      "tableplus"
      "the-unarchiver"
      "visual-studio-code"
      "zoom"
    ];
  };

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
        "com.apple.trackpad.scaling" = "3";
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

  users.nix.configureBuildUsers = true;
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
