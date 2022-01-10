{ inputs, config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix_2_5;

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';

    maxJobs = 8;
    buildCores = 8;
  };
}
