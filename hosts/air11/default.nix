{
  config,
  pkgs,
  ...
}: let
  rtl8723du = config.boot.kernelPackages.callPackage ./driver.nix {};
in {
  imports = [
    ./hardware-configuration.nix
    {
      dotfiles = {
        amd.enable = false;
        docker.enable = false;
        game.enable = false;
        gnome.enable = true;
        trackpad.enable = true;
        lxqt.enable = false;
        physical = {
          enable = true;
          boot.loader.useDefault = true;
          kernelPackages = pkgs.linuxPackages_5_15;
        };
      };
    }
  ];

  boot = {
    extraModulePackages = [rtl8723du];
    kernelModules = ["8723du"];
  };

  networking.hostName = "air11";

  sops.secrets."cachix-agent-token" = {
    format = "binary";
    sopsFile = ../../secrets/cachix-agent-token;
  };

  users.users.sakuraba = {
    isNormalUser = true;
    createHome = false;
    home = "/home/sakuraba";
    hashedPassword = "$6$EaDVfauYjKXpfWC4$XO5ef3u4TyD47UllLNYrsH.VwZIJ.oL/x5TdXAwrWnmiCwTF.2yM12bjJ98BA5TuVyAoU06KuwBEdpuJXWgGh.";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
      config.users.groups.keys.name
    ];
  };

  home-manager.users.sakuraba = import ../../home-manager;
}
