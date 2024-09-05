{...}: {
  imports = [
    ../../common/global
    ../../common/users/sakuraba.nix
  ];

  nix.settings.auto-optimise-store = false;
  networking.hostName = "QN63HFT2NY";
}
