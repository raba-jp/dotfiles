{ pkgs, ... }: {
  imports = [ ./pkgs.nix ./factorio.nix ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "auto";
      };

      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_zen;
  };

  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 34197 ];
    firewall.allowedUDPPorts = [ 34197 ];
    useDHCP = false;
  };

  sound.enable = true;

  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;
    nvidia.nvidiaSettings = true;
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

  services = {
    xserver = {
      enable = true;

      displayManager.gdm = {
        enable = true;
        wayland = true;
        nvidiaWayland = false;
      };
      desktopManager.gnome.enable = true;

      layout = "us";
      xkbOptions = "ctrl:nocaps";
      libinput.enable = true;
    };

    gnome.chrome-gnome-shell.enable = true;
  };

  nix = {
    trustedUsers = [ "root" "sakuraba" ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
  ];

  programs = { gnupg = { agent.enable = true; }; };

  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.05";
  };
}
