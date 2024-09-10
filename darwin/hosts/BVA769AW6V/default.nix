{pkgs, ...}: let
  hostName = "BVA769AW6V";
in {
  imports = [
    ../../common
  ];

  networking.hostName = hostName;

  users.users.sakuraba.name = "sakuraba";
  users.users.sakuraba.home = "/Users/sakuraba";
  users.users.sakuraba.shell = pkgs.zsh;
  home-manager.users.sakuraba = {
    imports = [
      ../../../home/profiles/desktop
    ];
    home.stateVersion = "24.11";
  };
}
