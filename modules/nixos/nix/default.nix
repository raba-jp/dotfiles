{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
in {
  config = {
    nix = {
      settings = {
        trusted-users = ["root" "@wheel"];
        substituters = [
          "https://raba-jp.cachix.org"
          "https://helix.cachix.org"
          "https://nix-community.cachix.org"
          "https://cache.nixos.org/"
        ];
        trusted-public-keys = [
          "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };

      package = pkgs.nix;

      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        experimental-features = nix-command flakes
      '';
    };

    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
  };
}
