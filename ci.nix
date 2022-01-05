let
  flake = (import ./flake-compat.nix).defaultNix;
  nixosConfigurations = flake.nixosConfigurations;
  darwinConfigurations = flake.darwinConfigurations;
in
{
  "build-define7" = nixosConfigurations.define7.config.system.build;
  "build-xps13" = nixosConfigurations.xps13.config.system.build;
  "build-darwin" = darwinConfigurations.SakurabaMBP.config.system.build;
}
