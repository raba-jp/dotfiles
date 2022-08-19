{
  description = "Nix system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    # Shell
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Utility
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cachix-deploy-flake = {
      url = "github:cachix/cachix-deploy-flake";
      inputs.darwin.follows = "darwin";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    darwin,
    home-manager,
    cachix-deploy-flake,
    flake-utils-plus,
    ...
  } @ inputs: let
    overlays = [
      (import ./overlays)
      (_final: prev: {
        helix-latest = inputs.helix.packages.${prev.system}.default;
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
  in
    flake-utils-plus.lib.eachDefaultSystem (system: {
      defaultPackage = let
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
        cachix-deploy-lib = cachix-deploy-flake.lib pkgs;
      in
        cachix-deploy-lib.spec {
          agent = {
            define7 = cachix-deploy-lib.nixos {
              imports = [
                home-manager.nixosModules.home-manager
                commonModules
                ./modules/nixos
                ./hosts/define7
              ];
            };

            air11 = cachix-deploy-lib.nixos {
              imports = [
                home-manager.nixosModules.home-manager
                commonModules
                ./modules/nixos
                ./hosts/air11
              ];
            };

            LF2107010038 = cachix-deploy-lib.darwin (
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
        };
    });
}
