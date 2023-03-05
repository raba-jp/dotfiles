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

    darwin.url = "github:LnL7/nix-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "darwin";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    helix.url = "github:helix-editor/helix";
    neovim.url = "github:neovim/neovim?dir=contrib";

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

    catppuccin-waybar = {
      url = "github:catppuccin/waybar";
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

    xpsSystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/hosts/xps13
      ];
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

          neovim = inputs.neovim.packages.${system}.default;

          deploySpec = pkgs.writeText "cachix-deploy.json" (builtins.toJSON {
            agents = {
              define7 = define7System.config.system.build.toplevel;
              xps = xpsSystem.config.system.build.toplevel;
            };
          });
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

      checks = {
        pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;

          hooks = {
            alejandra.enable = true;
            deadnix.enable = true;

            stylua.enable = true;
            shfmt.enable = true;

            actionlint.enable = true;
          };
        };
      };

      devShell = pkgs.callPackage ./shell.nix {
        inherit pkgs;
        inherit (self.checks.${system}.pre-commit) shellHook;
      };
    })
    // {
      overlays = import ./overlays;

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        define7 = define7System;
        xps = xpsSystem;
      };

      darwinConfigurations = {
        "QN63HFT2NY" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./darwin/hosts/QN63HFT2NY
          ];
          specialArgs = {inherit inputs outputs;};
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
