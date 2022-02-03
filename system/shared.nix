{ lib, pkgs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix_2_6;

    settings = {
      max-jobs = 8;
      cores = 8;

      substituters = [
        "https://raba-jp.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];

      trusted-public-keys = [
        "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    generateRegistryFromInputs = true;
    linkInputs = false;

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };
}
