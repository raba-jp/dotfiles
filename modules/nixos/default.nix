{pkgs, ...}: {
  imports = [
    # common
    ./nix
    ./boot
    ./network

    # Services
    ./services

    # devices
    ./trackpad

    # GPU
    ./amd

    ./docker
    ./game
    ./gnome
    ./nextdns.nix
    ./physical.nix
    ./lxqt.nix
  ];

  i18n = {
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [mozc];
      # fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    };
  };

  services.xserver = {
    layout = "us";
    xkbOptions = "ctrl:nocaps";
  };

  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.11";
  };
}
