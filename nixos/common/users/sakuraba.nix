{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  hmConfigPath = ../../../home/sakuraba/${config.networking.hostName}.nix;
  pathExists = builtins.pathExists hmConfigPath;
in {
  # TODO
  users.mutableUsers = true;
  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ [
        "docker"
        "network"
        "networkmanager"
        "git"
        "libvirtd"
      ];
  };

  home-manager.users.sakuraba = lib.mkIf pathExists import hmConfigPath;
}
