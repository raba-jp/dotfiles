{
  description = "Nix system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Darwin
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ISO images and VMs
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Utility
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    cachix-deploy-flake = {
      url = "github:cachix/cachix-deploy-flake";
      inputs.darwin.follows = "darwin";
    };

    helix.url = "github:helix-editor/helix";

    # fish shell plugins
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
    nixpkgs,
    home-manager,
    cachix-deploy-flake,
    helix,
    nixos-hardware,
    flake-utils,
    ...
  } @ inputs: let
    inherit (flake-utils.lib) system;

    overlays = [
      (import ./overlays)
      (_final: prev: {
        helix-latest = helix.packages.${prev.system}.default;
      })
    ];
    commonModules = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = inputs;
      };

      nixpkgs.overlays = overlays;
    };
  in {
    packages.${system.aarch64-darwin}.default = let
      pkgs = import nixpkgs {
        inherit overlays;
        system = system.aarch64-darwin;
        config.allowUnfree = true;
      };
      cachix-deploy-lib = cachix-deploy-flake.lib pkgs;
    in
      cachix-deploy-lib.spec {
        agents.LF2107010038 = cachix-deploy-lib.darwin (
          {...}: {
            imports = [
              home-manager.darwinModules.home-manager
              commonModules
              ./modules/darwin
              ./hosts/LF2107010038
            ];
          }
        );
      };

    packages.${system.x86_64-linux}.default = let
      pkgs = import nixpkgs {
        inherit overlays;
        system = system.x86_64-linux;
        config.allowUnfree = true;
      };
      cachix-deploy-lib = cachix-deploy-flake.lib pkgs;
    in
      cachix-deploy-lib.spec {
        agents = {
          define7 = cachix-deploy-lib.nixos {
            imports = [
              home-manager.nixosModules.home-manager
              commonModules
              ./modules/nixos
              ./hosts/define7
            ];
          };

          xps13 = cachix-deploy-lib.nixos {
            imports = [
              home-manager.nixosModules.home-manager
              commonModules
              nixos-hardware.nixosModules.common-cpu-intel
              nixos-hardware.nixosModules.common-gpu-intel
              nixos-hardware.nixosModules.common-pc-laptop
              nixos-hardware.nixosModules.common-pc-laptop-ssd
              nixos-hardware.nixosModules.common-gpu-nvidia-disable
              ./modules/nixos
              ./hosts/xps13
            ];
          };
        };
      };
  };
}
