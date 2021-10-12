{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim nixfmt ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  users.users.sakuraba = {
    name = "sakuraba";
    description = "Sakuraba Hiroki";
  };

  home-manager.users.sakuraba = { pkgs, ... }: {
    imports = [ ../../home/home.nix ../../home/darwin.nix ];
  };

  system = {
    stateVersion = 4;

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

  nixpkgs.config.allowUnfree = true;

}
