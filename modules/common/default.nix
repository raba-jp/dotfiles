{ inputs, config, pkgs, ... }: {
  imports = [ ./nixpkgs.nix ./ssh.nix ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}
