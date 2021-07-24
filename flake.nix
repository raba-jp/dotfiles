{
  inputs = { 
    nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-21.05";
  };

  outputs = { self, nixos, home-manager }@inputs: {
    nixosConfigurations = {
      define7-nixos = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
        ];
      };
      xps13 = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          machines/xps13/configuration.nix
        ];
      };
      respi4-internal = nixos.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ];
      };
      bootable-image = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ];
      };
    };
  };
}
