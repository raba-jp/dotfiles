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

    filterFiles = name: value: (value == "regular") || (value == "symlink");
    configFiles = filterAttrs filterFiles (builtins.readDir ./lua);
    toAttrs = f: _:
      nameValuePair
      ("nvim/lua/" + f)
      {
        source = ./lua + ("/" + f);
        executable = false;
      };
  in
    mapAttrs' toAttrs configFiles;

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
          # TODO: disable profiling
          config = ''
            require('impatient').enable_profile()
          '';
          type = "lua";
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
          plugin = buildVimPluginFrom2Nix {
            name = "nvim-treesitter-context";
            src = inputs.nvim-treesitter-context;
          };
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
          config = ''
            -- Recommended config from https://github.com/folke/noice.nvim
            require("noice").setup({
              lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                  ["vim.lsp.util.stylize_markdown"] = true,
                  ["cmp.entry.get_documentation"] = true,
                },
              },
              -- you can enable a preset for easier configuration
              presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
              },
            })
          '';
          type = "lua";
        }
        {
          plugin = buildVimPluginFrom2Nix {
            name = "gitsigns.nvim";
            src = inputs.gitsigns-nvim;
          };
        }
      ]
      ++ lspPlugins;

    extraConfig =
      "lua <<EOF\n"
      + (builtins.readFile ./init.lua)
      + "\nEOF";
  };
}
