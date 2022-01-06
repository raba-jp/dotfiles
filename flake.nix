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
    , ...
    }:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (nixos-unstable.lib) nixosSystem;
      inherit (nixos-generators) nixosGenerate;
      inherit (flake-utils.lib) eachDefaultSystem;

      overlays = { nixpkgs.overlays = [ ((import ./overlays) inputs) ]; };

      mkDarwinConfig =
        { system ? "x86_64-darwin"
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
            ./modules/nixos-desktop
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
            ./modules/nixos-vm
            overlays
          ] ++ modules;
          format = format;
        };
    in
    {
      darwinConfigurations = {
        SakurabaMBP = mkDarwinConfig {
          modules =
            [ ./modules/darwin/apps.nix ./profiles/darwin-personal.nix ];
        };
        LF2107010038 = mkDarwinConfig {
          modules = [ ./modules/darwin/apps.nix ./profiles/darwin-work.nix ];
        };
      };

      nixosConfigurations = {
        define7 = mkNixosConfig {
          modules =
            [ ./modules/hardwares/define7 ./profiles/linux-personal.nix ];
        };
        xps13 = mkNixosConfig {
          modules = [ ./modules/hardwares/xps13 ./profiles/linux-personal.nix ];
        };
      };

      packages.x86_64-linux = {
        vmware = mkBootableImage {
          format = "vmware";
          modules = [ ];
        };
        virtualbox = mkBootableImage {
          format = "virtualbox";
          modules = [ ];
        };
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
      pyEnv = (pkgs.python39.withPackages (ps: with ps; [ black ]));
    in
    {
      devShell = pkgs.devshell.mkShell {
        packages = [
          nixBin
          pyEnv
          pkgs.treefmt
          pkgs.nixfmt
          pkgs.stylua
          pkgs.shfmt
          pkgs.cargo-make
        ];
      };
    });
}
