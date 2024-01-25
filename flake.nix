{
  description = "My system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix.url = "github:helix-editor/helix";

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

    rose-pine-fish = {
      url = "github:rose-pine/fish";
      flake = false;
    };

    rose-pine-fcitx5 = {
      url = "github:rose-pine/fcitx5";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    darwin,
    ...
  } @ inputs: let
    inherit (flake-utils.lib) eachSystem;
    inherit (self) outputs;

    supportedSystems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

    define7System =
      nixpkgs.lib.nixosSystem
      {
        system = "x86_64-linux";
        modules = [./nixos/hosts/define7];
        specialArgs = {
          inherit inputs outputs;
        };
      };
  in
    eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages =
        (import ./pkgs {inherit pkgs;})
        // {
          helix = inputs.helix.packages.${system}.default;
        };

      homeConfigurations = {
        sakuraba = let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs outputs;
            };
            modules = [./home/users/sakuraba/home.nix];
          };
      };
    })
    // {
      overlays = import ./overlays;

      nixosConfigurations = {
        define7 = define7System;
      };

      darwinConfigurations = {
        "QN63HFT2NY" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./darwin/hosts/QN63HFT2NY
          ];
          specialArgs = {inherit inputs outputs;};
        };
        "BVA769AW6V" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./darwin/hosts/BVA769AW6V
          ];
          specialArgs = {inherit inputs outputs;};
        };
      };

      nixConfig = {
        extra-substituers = [
          "https://raba-jp.cachix.org"
          "https://nix-community.cachix.org"
          "https://helix.cachix.org"
        ];
        extra-trusted-public-keys = [
          "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        ];
      };
    };
}
