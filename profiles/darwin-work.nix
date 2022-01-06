{ pkgs, ... }: {
  users.users."hiroki.sakuraba" = {
    name = "hiroki.sakuraba";
    home = "/Users/hiroki.sakuraba";
  };

  home-manager.users."hiroki.sakuraba" = import ../modules/home-manager;
}
