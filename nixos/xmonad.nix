{ config, pkgs, ... }: {
  programs.dconf.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gnome.dconf ];
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];

      layout = "us";
      libinput.enable = true;

      displayManager = { defaultSession = "none+xmonad"; };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}
