{ inputs, config, pkgs, nixpkgs, stable, ... }: {
  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [
      (final: prev: { stable = import stable { system = prev.system; }; })
      (final: prev: rec { kitty = prev.stable.kitty; })
      (final: prev: { fonts = (import ./fonts); })
    ];
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
