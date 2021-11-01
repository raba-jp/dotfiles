{ pkgs, ... }: {
  home-manager = {
    users.sakuraba = import ../../modules/home-manager;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
