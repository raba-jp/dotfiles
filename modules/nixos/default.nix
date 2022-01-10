{ config, pkgs, lib, ... }: {
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
  };

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

  # systemd.services.cachix-agent = {
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network.target" ];
  #   description = "Start Cachix deploy agent.";
  #   serviceConfig = {
  #     Type = "simple";
  #     Restart = "always";
  #     ExecStart = ''${pkgs.cachix}/bin/cachix deploy agent ${config.networking.hostName}'';
  #     EnvironmentFile = "/etc/cachix/agent/token";
  #   };
  # };

  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.11";
  };
}
