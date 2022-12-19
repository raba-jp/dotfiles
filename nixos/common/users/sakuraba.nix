{config, ...}: {
  users.mutableUsers = false;
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
    hashedPassword = "$6$pfJbTwMjGKRLZED.$E7VDlAVGg75bOgdnEo11Q9GCHH0M0RQk3VXlTotAxsE0EpypbiOAWbe8AsdwtgDCPbBtrSQ5zqrqYyX28qAO9.";
  };

  home-manager.users.sakuraba = import ../../../home/users/sakuraba/${config.networking.hostName}.nix;
}
