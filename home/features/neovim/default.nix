{
  lib,
  pkgs,
  outputs,
  ...
}: {
  xdg.configFile = let
    getConfigFiles = dir:
      lib.filterAttrs
      (n: _v: (lib.hasSuffix ".lua" n) || (lib.hasSuffix "lazy-lock.json" n))
      (
        lib.listToAttrs (map
          (file:
            lib.nameValuePair
            ("nvim/" + (lib.removePrefix ("${toString dir}" + "/") (toString file)))
            {
              source = file;
              executable = false;
            })
          (lib.filesystem.listFilesRecursive dir))
      );
  in
    getConfigFiles ./.;

  programs.neovim = {
    enable = true;

    # TODO: ref: https://github.com/NixOS/nixpkgs/issues/229275
    package = lib.mkIf pkgs.stdenvNoCC.isLinux outputs.packages.${pkgs.system}.neovim;
    extraPackages = with pkgs; [
      gcc
      gnumake
    ];

    defaultEditor = true;
  };
}
