{config, ...}: {
  users.mutableUsers = false;
  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "docker"
      "network"
      "networkmanager"
      "git"
      "libvirtd"
    ];
    hashedPassword = "$6$pfJbTwMjGKRLZED.$E7VDlAVGg75bOgdnEo11Q9GCHH0M0RQk3VXlTotAxsE0EpypbiOAWbe8AsdwtgDCPbBtrSQ5zqrqYyX28qAO9.";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO3XXec588RHW99sDhZjQoWs4OzexPGvu1zDTErUB4J"
    ];
  };

  home-manager.users.sakuraba = import "../../../home/users/sakuraba/${config.networking.hostName}.nix";
}
