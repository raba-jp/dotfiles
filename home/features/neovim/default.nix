{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;

    plugins = [
      {
        plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "catppuccin";
          src = inputs.catppuccin-nvim;
        };
        config = ''
          colorscheme catppuccin-mocha
        '';
      }
      {
        plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
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
        plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
        config = ''
          require('nvim-treesitter.configs').setup({
            ensure_installed = "all",
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            },
            indent = {
              enable = true
            },
          })
        '';
        type = "lua";
      }
      {
        plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "nvim-lspconfig";
          src = inputs.nvim-lspconfig;
        };
      }
    ];

    extraConfig =
      "lua <<EOF\n"
      + (builtins.readFile ./init.lua)
      + "\nEOF";
  };
}
