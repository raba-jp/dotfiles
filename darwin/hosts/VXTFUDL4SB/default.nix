{...}: let
  hostName = "VXTFUDL4SB";
  username = "sakuraba";
in {
  imports = [
    ../../common
  ];

  networking.hostName = hostName;

  users.users.sakuraba.name = "sakuraba";
  users.users.sakuraba.home = "/Users/sakuraba";
  home-manager.users.sakuraba = {
    imports = [
      ../../../home/profiles/desktop
    ];
    home.stateVersion = "25.05";
  };

  system.primaryUser = username;
}
