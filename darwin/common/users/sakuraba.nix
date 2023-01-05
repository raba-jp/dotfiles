{config, ...}: {
  users.users."hiroki.sakuraba" = {
    name = "Hiroki Sakuraba";
    home = "/Users/sakuraba";
  };

  home-manager.users."sakuraba" = import ../../../home/users/sakuraba/${config.networking.hostName}.nix;
}
