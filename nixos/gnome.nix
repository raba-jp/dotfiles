{ config, pkg, ... }: {
  console.useXkbConfig = true;

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];

      displayManager = {
        gdm = {
          enable = true;
          wayland = false;
          nvidiaWayland = false;
        };
      };
      desktopManager = { gnome.enable = true; };

      layout = "us";
      xkbOptions = "ctrl:nocaps";
      libinput.enable = true;
    };

    gnome.chrome-gnome-shell.enable = true;
  };
}
