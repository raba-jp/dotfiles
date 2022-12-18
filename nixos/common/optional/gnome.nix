{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;

      desktopManager.gnome = {
        enable = true;
      };

      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };

    gnome = {
      games.enable = true;
      gnome-browser-connector.enable = true;
    };
  };

  networking.networkmanager.enable = true;
  programs.dconf.enable = true;

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome.cheese
      gnome-photos
      gnome.gnome-music
      gnome.gnome-terminal
      gnome.gedit
      gnome.epiphany
      evince
      gnome.gnome-characters
      gnome.totem
      gnome.tali
      gnome.iagno
      gnome.hitori
      gnome.atomix
      gnome-tour
      gnome.geary
      gnome.gnome-calculator
      gnome.simple-scan
      gnome.gnome-remote-desktop
      gnome.vinagre
      gnome.gnome-boxes
      gnome-connections
    ];

    systemPackages = with pkgs; [
      gnome.gnome-tweaks
      catppuccin-gtk
      catppuccin-cursors
    ];
  };
}
