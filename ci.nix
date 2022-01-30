let
  shell = import ./shell.nix { };
  pkgs = shell.pkgs;
  flake = (import ./flake-compat.nix).defaultNix;
in
{
  inherit shell;

  build = effects.runCachixDeploy {
    deploy.agents."define7" = flake.nixosConfigurations.define7.config.system.build.toplevel;
  };
}
