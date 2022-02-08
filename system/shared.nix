{ lib, pkgs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    # package = pkgs.nix_2_6;
    package = pkgs.nix_2_5;

    # settings = {
    #   max-jobs = 8;
    #   cores = 8;

    #   substituters = [
    #     "https://raba-jp.cachix.org"
    #     "https://nix-community.cachix.org"
    #     "https://cache.nixos.org/"
    #   ];

    #   trusted-public-keys = [
    #     "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
    #     "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    #   ];
    # };
    maxJobs = 8;
    buildCores = 8;

    binaryCaches = [
      "https://raba-jp.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    binaryCachePublicKeys = [
      "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };
}
