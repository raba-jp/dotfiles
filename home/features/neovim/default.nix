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
    inherit (lib.attrsets) filterAttrs nameValuePair mapAttrs';

    configFiles =
      filterAttrs
      (_name: value: (value == "regular") || (value == "symlink"))
      (
        (mapAttrs' (f: v: nameValuePair ("lua/core/" + f) v) (builtins.readDir ./lua/core))
        // (mapAttrs' (f: v: nameValuePair ("lua/plugins/" + f) v) (builtins.readDir ./lua/plugins))
        // {"init.lua" = "regular";}
      );
  in
    mapAttrs' (f: _:
      nameValuePair
      ("nvim/" + f)
      {
        source = ./. + ("/" + f);
        executable = false;
      })
    configFiles;

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
