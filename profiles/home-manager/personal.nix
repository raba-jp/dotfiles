{ pkgs, ... }: {
  home-manager.users.sakuraba = import ../../modules/home-manager;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}
