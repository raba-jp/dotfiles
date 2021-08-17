{ config, pkg, ... }: {
  console.useXkbConfig = true;

  services = {
    xserver = {
      enable = true;

      displayManager = {
        gdm = {
          enable = true;
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
