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

    filterFiles = _name: value: (value == "regular") || (value == "symlink");
    configFiles = filterAttrs filterFiles (builtins.readDir ./lua);
    toAttrs = f: _:
      nameValuePair
      ("nvim/lua/" + f)
      {
        source = ./lua + ("/" + f);
        executable = false;
      };
  in
    mapAttrs' toAttrs configFiles // {"nvim/init.lua".source = ./init.lua;};

  programs.neovim = {
    enable = true;
    package = outputs.packages.${pkgs.system}.neovim;

    plugins = [
      {
        plugin = buildVimPluginFrom2Nix {
          name = "impatient.nvim";
          src = inputs.impatient-nvim;
        };
      }
      {
        plugin = buildVimPluginFrom2Nix {
          name = "lazy.nvim";
          src = inputs.lazy-nvim;
        };
      }
    ];
  };
}
