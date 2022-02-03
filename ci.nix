let
  shell = import ./shell.nix;
  pkgs = shell.pkgs;
  flake = (import ./flake-compat.nix).defaultNix;
in
pkgs.writeText "cachix-deploy.json" (builtins.toJSON {
  agents = {
    define7 = flake.nixosConfigurations.define7.config.system.build.toplevel;
  };
})
