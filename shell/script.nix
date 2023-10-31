{pkgs, ...}: {
  scripts = {
    rebuild.exec = let
      linux = ''
        sudo nixos-rebuild switch --flake .#$(hostname)
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
