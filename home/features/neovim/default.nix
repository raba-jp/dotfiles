{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: let
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;

  lspPlugins = import ./lsp.nix {inherit pkgs inputs;};
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

    plugins = with pkgs.vimPlugins;
      [
        {
          plugin = buildVimPluginFrom2Nix {
            name = "impatient.nvim";
            src = inputs.impatient-nvim;
          };
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "plenary.nvim";
            src = inputs.plenary-nvim;
          };
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "nvim-web-devicons";
            src = inputs.nvim-web-devicons;
          };
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "catppuccin";
            src = inputs.catppuccin-nvim;
          };
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "lualine";
            src = inputs.lualine-nvim;
          };
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "nvim-treesitter-context";
            src = inputs.nvim-treesitter-context;
          };
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "nui.nvim";
            src = inputs.nui-nvim;
          };
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "nvim-notify";
            src = inputs.nvim-notify;
          };
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "noice.nvim";
            src = inputs.noice-nvim;
          };
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "gitsigns.nvim";
            src = inputs.gitsigns-nvim;
          };
        }
      ]
      ++ lspPlugins;
  };
}
