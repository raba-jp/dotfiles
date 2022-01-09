{ config, pkgs, lib, ... }: {
  imports = [
    ./gnome.nix
    # ./i3.nix
  ];

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


  sound.enable = true;

  networking = {
    networkmanager.enable = true;
    useDHCP = false;

    firewall = {
      allowedTCPPorts = [ 34197 ];
      allowedUDPPorts = [ 34197 ];
    };
  };

  hardware = {
    pulseaudio.enable = true;

    opengl.enable = true;

    nvidia.nvidiaSettings = true;
  };

  i18n = {
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
      # fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    };
  };

  virtualisation.docker.enable = true;

  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbOptions = "ctrl:nocaps";
      libinput.enable = true;
    };

    udev.packages = [ pkgs.via ];
    gnome.chrome-gnome-shell.enable = true;

    factorio = lib.mkIf (config.networking.hostName == "define7") {
      enable = true;
      public = false;
    };
  };

  programs = { steam.enable = true; };

  environment = {
    systemPackages = with pkgs; [
      chromium
      gnome.gnome-tweaks
      nixos-generators
    ];
  };
}
