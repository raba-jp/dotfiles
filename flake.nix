{
  description = "Nix system configurations";

  inputs = {
    darwin-stable.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, nixpkgs, darwin, home-manager, devshell, flake-utils, ... }:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (nixpkgs.lib) nixosSystem;
      inherit (flake-utils.lib) eachDefaultSystem;

      mkDarwinConfig = { system ? "x86_64-darwin", nixpkgs ? inputs.nixpkgs
        , stable ? inputs.darwin-stable, modules ? [ ] }:
        darwinSystem {
          inherit system;
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/common
            ./modules/darwin
            ./overlays
          ] ++ modules;
          specialArgs = { inherit inputs nixpkgs stable; };
        };

      mkNixosConfig = { system ? "x86_64-linux", nixpkgs ? inputs.nixos-unstable
        , stable ? inputs.nixos-stable, modules ? [ ] }:
        nixosSystem {
          inherit system;
          modules = [
            home-manager.nixosModules.home-manager
            ./modules/common
            ./modules/nixos
            ./overlays
          ] ++ modules;
          specialArgs = { inherit inputs nixpkgs stable; };
        };

    in {
      darwinConfigurations = {
        SakurabaMBP = mkDarwinConfig {
          modules =
            [ ./modules/darwin/apps.nix ./profiles/darwin-personal.nix ];
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
    } // eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
        nixBin = pkgs.writeShellScriptBin "nix" ''
          ${pkgs.nixFlakes}/bin/nix --option experimental-features "nix-command flakes" "$@"
        '';
        pyEnv = (pkgs.python39.withPackages (ps: with ps; [ black ]));
      in {
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
