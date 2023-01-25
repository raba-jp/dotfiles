{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: let
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
in {
  xdg.configFile = let
    getConfigFiles = dir:
      lib.filterAttrs
      (n: _v: lib.hasSuffix ".lua" n)
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
    package = outputs.packages.${pkgs.system}.neovim;

    plugins = [
      {
        plugin = buildVimPluginFrom2Nix {
          name = "lazy.nvim";
          src = inputs.lazy-nvim;
        };
      }
    ];
  };
}
