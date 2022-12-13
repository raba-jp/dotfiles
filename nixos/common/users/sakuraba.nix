{
  config,
  ...
}: let
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

  home-manager.users.sakuraba =
    if pathExists
    then import hmConfigPath
    else {
      home.stateVersion = "22.11";
    };
}
