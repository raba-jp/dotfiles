{ config, pkg, ... }: {
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];

      displayManager = { gdm.enable = true; };
      desktopManager = { gnome.enable = true; };

      layout = "us";
      libinput.enable = true;
    };

    gnome.chrome-gnome-shell.enable = true;
  };
}
