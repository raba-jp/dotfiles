let
  shell = import ./shell.nix;
  pkgs = shell.pkgs;
  flake = (import ./flake-compat.nix).defaultNix;
in
{
  # inherit shell;

  deploy = pkgs.effects.runCachixDeploy {
    deploy.agents = {
      define7 = flake.nixosConfigurations.define7.config.system.build.toplevel;
    };
    secretsMap.activate = "dotfiles";
  };
}
