{...}: {
  imports = [
    ../../common/global
    ../../common/users/sakuraba.nix
  ];

  nix.settings.auto-optimise-store = false;
  networking.hostName = "BVA769AW6V";
}
