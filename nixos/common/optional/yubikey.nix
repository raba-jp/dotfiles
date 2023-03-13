{pkgs, ...}: {
  services.udev.packages = [pkgs.yubikey-personalization];
  services.yubikey-agent.enable = true;

  environment.systemPackages = with pkgs; [
    pinentry-gnome
  ];
}
