{
  description = "Nix system configurations";

  inputs = {
    darwin-stable.url = "github:nixos/nixpkgs/nixpkgs-21.05-darwin";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-21.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (nixpkgs.lib) nixosSystem;

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

      mkNixosCOnfig = { system ? "x86_64-linux", nixpkgs ? inputs.nixos-unstable
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
          modules = [
            ./modules/darwin/apps.nix
            ./profiles/darwin/personal.nix
            ./profiles/home-manager/personal.nix
          ];
        };
      };

      nixosConfigurations = {
        define7 = mkNixosCOnfig {
          modules = [
            ./modules/hardware/define7
            ./profiles/nixos/personal.nix
            ./profiles/home-manager/personal.nix
          ];
        };
        xps13 = mkNixosCOnfig {
          modules = [
            ./modules/hardware/xps13
            ./profiles/nixos/personal.nix
            ./profiles/home-manager/personal.nix
          ];
        };
      };
    };
}
