{ pkgs, ... }: {
  networking.hostName = "LF2107010038";

  users.users."hiroki.sakuraba" = {
    name = "hiroki.sakuraba";
    home = "/Users/hiroki.sakuraba";
  };

  home-manager.users."hiroki.sakuraba" = import ../../home-manager;
}
