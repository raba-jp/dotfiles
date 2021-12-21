{ pkgs, ... }: {

  services.xserver = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
      nvidiaWayland = false;
    };

    desktopManager.gnome.enable = true;
  };
}
