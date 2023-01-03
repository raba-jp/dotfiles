{config, ...}: {
  users.users."hiroki.sakuraba" = {
    name = "Hiroki Sakuraba";
    home = "/Users/hiroki.sakuraba";
  };

  home-manager.users."hiroki.sakuraba" = import ../../../home/users/sakuraba/${config.networking.hostName}.nix;
}
