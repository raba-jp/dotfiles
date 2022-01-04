{ config, pkgs, lib, ... }: {
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };

  sound.enable = true;

  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;
  };

  time.timeZone = "Asia/Tokyo";
  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
      # fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    };
  };

  fonts = {
    fonts = with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-emoji cica ];
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      serif = [ "Noto Sans CJK JP" ];
      sansSerif = [ "Noto Sans Mono CJK JP" ];
    };
  };

  virtualisation.docker.enable = true;

  console.useXkbConfig = true;

  services = { openssh.enable = true; };

  nix = {
    trustedUsers = [ "root" "sakuraba" ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs = {
    gnupg = { agent.enable = true; };
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [ libnotify wget ];

  systemd.services.cachix-agent = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Start Cachix deploy agent.";
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      ExecStart = ''${pkgs.cachix}/bin/cachix deploy agent agent ${config.networking.hostName}'';
      EnvironmentFile = "/etc/cachix/agent/token";
    };
  };

  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.11";
  };
}
