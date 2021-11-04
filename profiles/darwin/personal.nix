{ pkgs, ... }: {
  users.users.sakuraba = {
    name = "sakuraba";
    description = "Sakuraba Hiroki";
    home = "/Users/sakuraba";
  };

  home-manager = {
    users.sakuraba = { imports = [ ../../modules/home-manager ]; };
  };
}
