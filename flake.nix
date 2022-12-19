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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cachix-deploy-flake = {
      url = "github:cachix/cachix-deploy-flake";
      # inputs.darwin.follows = "darwin";
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

    catppuccin-nvim = {
      url = "github:catppuccin/nvim";
      flake = false;
    };

    lualine-nvim = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };

    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };

    #  'hrsh7th/cmp-cmdline'
    #  'hrsh7th/nvim-cmp'
  };
  outputs = {
    self,
    nixpkgs,
    nixos-generators,
    nixos-hardware,
    flake-utils,
    cachix-deploy-flake,
    home-manager,
    ...
  } @ inputs: let
    inherit (flake-utils.lib) eachSystem;
    inherit (self) outputs;

    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    define7Modules = [
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-cpu-amd-pstate
      nixos-hardware.nixosModules.common-gpu-amd
      nixos-hardware.nixosModules.common-pc-ssd
      ./nixos/hosts/define7
    ];
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
              inherit inputs outputs;
            };
          };

          deploy = pkgs.writeText "cachix-deploy.json" (builtins.toJSON {
            agents = {
              define7 =
                (nixpkgs.lib.nixosSystem
                  {
                    system = "x86_64-linux";
                    modules = define7Modules;
                    specialArgs = {
                      inherit inputs outputs;
                    };
                  })
                .config
                .system
                .build
                .toplevel;
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
    })
    // {
      overlays = import ./overlays;

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        define7 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
          ];
          specialArgs = {
            inherit inputs outputs;
          };
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
