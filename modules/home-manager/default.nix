{
  pkgs,
  inputs,
  overlays,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = inputs;
  };

  nixpkgs.overlays = overlays;
}
