{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
  lspPlugins = import ./lsp.nix {inherit pkgs inputs;};
in {
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins;
      [
        {
          plugin = buildVimPluginFrom2Nix {
            name = "catppuccin";
            src = inputs.catppuccin-nvim;
          };
          config = ''
            colorscheme catppuccin-mocha
          '';
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "lualine";
            src = inputs.lualine-nvim;
          };
          config = ''
            require('lualine').setup({
              options = {
                theme = "catppuccin"
              }
            })
          '';
          type = "lua";
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
          config = ''
            require("nvim-treesitter.configs").setup({
            	sync_install = false,
            	highlight = { enable = true },
            	indent = { enable = true },
            	lsp_interop = { enable = true },
            	refactor = {
            		navigation = { enable = true },
            		highlight_definitions = { enable = true },
            		highlight_current_scope = { enable = true },
            	},
            	rainbow = { enable = true },
            })
          '';
          type = "lua";
        }
      ]
      ++ lspPlugins;

    extraConfig =
      "lua <<EOF\n"
      + (builtins.readFile ./init.lua)
      + "\nEOF";
  };
}
