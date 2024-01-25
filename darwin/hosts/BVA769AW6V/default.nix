{...}: {
  imports = [
    ../../common/global
    ../../common/optional/defaults.nix
    ../../common/users/sakuraba.nix
  ];

  nix.settings.auto-optimise-store = false;
  networking.hostName = "BVA769AW6V";
}
