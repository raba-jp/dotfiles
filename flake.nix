{
  description = "My system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fish-done = {
      url = "github:franciscolourenco/done";
      flake = false;
    };

    fish-ghq = {
      url = "github:decors/fish-ghq";
      flake = false;
    };

    fish-fzf = {
      url = "github:jethrokuan/fzf";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-generators,
    flake-utils,
    home-manager,
    helix,
    ...
  } @ inputs: let
    inherit (flake-utils.lib) system eachSystem flattenTree;
    inherit (self) outputs;

    supportedSystems = [system.x86_64-linux system.aarch64-linux];
  in {
    overlays = import ./overlays;

    packages = eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
      (import ./pkgs {inherit pkgs;})
      // {
        vm = nixos-generators.nixosGenerate {
          inherit system;
          format = "vm";
        };
      });

    homeConfigurations = {
      "sakuraba@generic" = let
        pkgs = nixpkgs {system = system.x86_64-linux;};
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [];
        };
    };

    nixConfig = {
      extra-substituers = [
        "https://raba-jp.cachix.org"
        "https://helix.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
