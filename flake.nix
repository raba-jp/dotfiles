{
  description = "Nix system configurations";

  inputs = {
    nixos-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin-stable.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixos-unstable";
    };
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    ## NeoVim Plugins
    vim-edgemotion = {
      url = "github:haya14busa/vim-edgemotion";
      flake = false;
    };
    format-nvim = {
      url = "github:lukas-reineke/format.nvim";
      flake = false;
    };
    nordic-nvim = {
      url = "github:andersevenrud/nordic.nvim";
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
    lspsaga-nvim = {
      url = "github:tami5/lspsaga.nvim";
      flake = false;
    };
    telescope-ghq-nvim = {
      url = "github:nvim-telescope/telescope-ghq.nvim";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:kyazdani42/nvim-web-devicons";
      flake = false;
    };
    which-key-nvim = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };

    telescope-command-palette-nvim = {
      url = "github:LinArcX/telescope-command-palette.nvim";
      flake = false;
    };

    cheatsheet-nvim = {
      url = "github:sudormrfbin/cheatsheet.nvim";
      flake = false;
    };

    octo-nvim = {
      url = "github:pwntester/octo.nvim";
      flake = false;
    };
    cachix.url = "github:cachix/cachix";
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent";
    hercules-ci-effects.url = "github:hercules-ci/hercules-ci-effects";
  };

  outputs =
    inputs@{ self
    , nixos-stable
    , nixos-unstable
    , darwin
    , home-manager
    , nixos-generators
    , devshell
    , flake-utils
    , hercules-ci-effects
    , ...
    }:
    let
      pkgs = import nixos-unstable {
        system = "x86_64-linux";
        overlays = [ hercules-ci-effects.overlay ];
      };

      inherit (darwin.lib) darwinSystem;
      inherit (nixos-unstable.lib) nixosSystem;
      inherit (nixos-generators) nixosGenerate;
      inherit (flake-utils.lib) eachDefaultSystem;

      overlays = { nixpkgs.overlays = [ ((import ./overlays) inputs) ]; };

      mkDarwinConfig =
        { system ? "aarch64-darwin"
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.darwin-stable
        , modules ? [ ]
        }:
        darwinSystem {
          inherit system;
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/common
            ./modules/darwin
            overlays
          ] ++ modules;
          specialArgs = { inherit inputs nixpkgs stable; };
        };

      mkNixosConfig =
        { system ? "x86_64-linux"
        , nixpkgs ? inputs.nixos-unstable
        , stable ? inputs.nixos-stable
        , modules ? [ ]
        }:
        nixosSystem {
          inherit system;
          modules = [
            home-manager.nixosModules.home-manager
            ./modules/common
            ./modules/nixos
            overlays
          ] ++ modules;
          specialArgs = { inherit inputs nixpkgs stable; };
        };

      mkBootableImage =
        { format
        , nixpkgs ? inputs.nixos-unstable
        , stable ? inputs.nixos-stable
        , modules ? [ ]
        }:
        nixosGenerate {
          pkgs = nixpkgs.legacyPackages.x86_64-linux.extend ((import ./overlays) inputs);
          modules = [
            home-manager.nixosModules.home-manager
            ./modules/common
            ./modules/nixos
            overlays
          ] ++ modules;
          format = format;
        };
    in
    {
      darwinConfigurations = {
        LF2107010038 = mkDarwinConfig {
          modules = [ ./modules/darwin/apps.nix ./profiles/darwin-work.nix ];
        };
      };

      nixosConfigurations = {
        define7 = mkNixosConfig {
          modules =
            [
              ./modules/hardwares/define7
              ./modules/nixos-desktop
              ./profiles/linux-personal.nix
              ({ config, lib, pkgs, ... }: {
                imports = [ inputs.hercules-ci-agent.nixosModules.agent-service ];
                services.hercules-ci-agent.enable = true;
              })
            ];
        };

        xps13 = mkNixosConfig {
          modules = [
            ./modules/hardwares/xps13
            ./modules/nixos-desktop
            ./profiles/linux-personal.nix
          ];
        };

        sirius = mkNixosConfig {
          modules = [
            ({ config, lib, pkgs, ... }: {
              imports = [ inputs.hercules-ci-agent.nixosModules.agent-service ];
              services.hercules-ci-agent.enable = true;
            })
          ];
        };
      };

      packages.x86_64-linux = {
        vmware = mkBootableImage {
          format = "vmware";
          modules = [ ./modules/nixos-desktop/vm.nix ];
        };
        virtualbox = mkBootableImage {
          format = "virtualbox";
          modules = [ ./modules/nixos-desktop/vm.nix ];
        };
        server = mkBootableImage {
          format = "do";
          modules = [
            ({ config, lib, pkgs, ... }: {
              imports = [ inputs.hercules-ci-agent.nixosModules.agent-service ];
              services.hercules-ci-agent.enable = true;
            })
          ];
        };
      };

      deploy = pkgs.effects.runCachixDeploy {
        deploy.agents."define7" = self.nixosConfigurations.define7.config.system.build.toplevel;
        secretsMap.activate = "default-cachix-activate";
      };

    } // eachDefaultSystem (system:
    let
      pkgs = import nixos-unstable {
        inherit system;
        overlays = [ devshell.overlay ];
      };
      nixBin = pkgs.writeShellScriptBin "nix" ''
        ${pkgs.nixFlakes}/bin/nix --option experimental-features "nix-command flakes" "$@"
      '';
    in
    {
      devShell = pkgs.devshell.mkShell {
        packages = [
          nixBin
          pkgs.cargo-make
          pkgs.nix-build-uncached
        ];
      };

    });
}
