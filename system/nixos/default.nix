{ config, lib, pkgs, ... }: {
  imports = [ ../shared.nix ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "auto";
      };

      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "ja_JP.UTF-8";
  };

  fonts = {
    fonts = with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-emoji cica ];
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      serif = [ "Noto Sans CJK JP" ];
      sansSerif = [ "Noto Sans Mono CJK JP" ];
    };
  };

  console.useXkbConfig = true;

  services = {
    openssh.enable = true;

    cachix-agent = {
      enable = true;
      name = config.networking.hostName;
      credentialsFile = config.sops.secrets."cachix-agent-token".path;
    };
  };

  sops.secrets."cachix-agent-token" = {
    format = "binary";
    sopsFile = ../../secrets/cachix-agent-token;
  };

  nix = {
    settings = {
      trusted-users = [ "root" "sakuraba" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.gnupg.agent.enable = true;

  environment.systemPackages = with pkgs; [ libnotify wget ];

  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.11";
  };
}
