{pkgs, ...}: {
  programs.gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };
  };
  services.dbus.packages = [pkgs.gcr];
}
