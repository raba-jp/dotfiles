{ inputs, config, pkgs, nixpkgs, stable, ... }: {
  nixpkgs = {
    config = { allowUnfree = true; };
  };

  nix = {
    package = pkgs.nix_2_4;

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';

    maxJobs = 8;
    buildCores = 8;

    registry = {
      nixpkgs = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        flake = nixpkgs;
      };

      stable = {
        from = {
          id = "stable";
          type = "indirect";
        };
        flake = stable;
      };
    };
  };
}
