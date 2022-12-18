{
  description = "My system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
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

    catppuccin-fish = {
      url = "github:catppuccin/fish";
      flake = false;
    };

    catppuccin-gitui = {
      url = "github:catppuccin/gitui";
      flake = false;
    };

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };

    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
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
  in
    eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages =
        (import ./pkgs {inherit pkgs;})
        // {
          iso = nixos-generators.nixosGenerate {
            inherit system;
            format = "iso";
            modules = [./nixos/hosts/iso];
            specialArgs = {
              inherit inputs outputs system;
            };
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
            extraSpecialArgs = {
              inherit inputs outputs system;
            };
            modules = [./home/users/sakuraba/home.nix];
          };
      };

      nixConfig = {
        extra-substituers = [
          "https://raba-jp.cachix.org"
          "https://helix.cachix.org"
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
          "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
}
