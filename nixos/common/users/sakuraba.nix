{config, ...}: {
  age.secrets.passwordfile_sakuraba.file = ../../../secrets/passwordfile-sakuraba.age;

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

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO3XXec588RHW99sDhZjQoWs4OzexPGvu1zDTErUB4J"
    ];

    mutableUsers = true;
    initialPassword = "12345678";
  };

  home-manager.users.sakuraba = import (../../../. + "/home/users/sakuraba/${config.networking.hostName}.nix");
}
