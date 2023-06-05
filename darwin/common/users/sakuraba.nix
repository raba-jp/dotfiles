{config, ...}: {
  users.users.sakuraba = {
    name = "sakuraba";
    home = "/Users/sakuraba";
  };

  home-manager.users."sakuraba" = import ../../../home/users/sakuraba/${config.networking.hostName}.nix;
}
