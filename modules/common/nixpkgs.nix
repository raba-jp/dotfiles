{ inputs, config, pkgs, nixpkgs, stable, ... }: {
  nixpkgs = {
    config = { allowUnfree = true; };
  };

  nix = {
    package = pkgs.nixFlakes;

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
