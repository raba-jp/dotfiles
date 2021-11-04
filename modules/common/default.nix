{ inputs, config, pkgs, ... }: {
  imports = [ ./nixpkgs.nix ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}
