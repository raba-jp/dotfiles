{pkgs, ...}: {
  scripts = {
    rebuild-define7.exec = let
      linux = ''
        sudo nixos-rebuild switch --flake .#nixosConfigurations.define7.config.system.build.toplevel
      '';
      darwin = ''
      '';
      script = pkgs.writeShellScript "build" (
        if pkgs.stdenv.isLinux
        then linux
        else darwin
      );
    in
      builtins.toString script;
  };
}
