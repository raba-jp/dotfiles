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
    ...
  } @ inputs: let
    inherit (flake-utils.lib) system eachSystem;
    inherit (self) outputs;

    supportedSystems = [system.x86_64-linux system.aarch64-linux];

    specialArgs = {inherit inputs outputs;};
  in
    eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages =
        (import ./pkgs {inherit pkgs;})
        // {
          vm = nixos-generators.nixosGenerate {
            inherit system specialArgs;
            format = "vm";
            modules = [./nixos/vm];
          };
        };
    })
    // {
      overlays = import ./overlays;

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      homeConfigurations = {
        sakuraba = let
          pkgs = import nixpkgs {system = system.x86_64-linux;};
        in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = specialArgs;
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
