{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }@inputs: {
    nixosConfigurations = {
      define7 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./machines/define7/configuration.nix
        ];
      };

      xps13 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./machines/xps13/configuration.nix
        ];
      };

      respi4-internal = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ];
      };

      bootable-image = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ];
      };
    };
    darwinConfigurations = {
      SakurabaMBP = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./machines/SakurabaMBP/darwin-configuration.nix
        ];
      };
    };
  };
}
