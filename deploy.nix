let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  pkgs = import
    (fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.nodes.nixos-unstable.locked.rev}.tar.gz";
      sha256 = lock.nodes.nixos-unstable.locked.narHash;
    })
    { };

  flake = (import ./flake-compat.nix).defaultNix;
  nixosConfigurations = flake.nixosConfigurations;
  darwinConfigurations = flake.darwinConfigurations;
in
pkgs.writeText "cachix-deploy.json" (builtins.toJSON {
  agents = {
    define7 = nixosConfigurations.define7.config.system.build.toplevel;
    # xps13 = nixosConfigurations.xps13.config.system.build.toplevel;
  };
})
