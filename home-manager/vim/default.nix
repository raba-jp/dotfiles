{ lib, pkgs, ... }@args:
let
  inherit (pkgs.vimUtils) buildVimPlugin buildVimPluginFrom2Nix;
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      tree-sitter
      gopls
      rust-analyzer
      sumneko-lua-language-server
      rnix-lsp
      nodePackages.pyright
      nodePackages.typescript-language-server
      rubyPackages.solargraph
      terraform-ls
      efm-langserver
    ];

    plugins = [
      { plugin = buildVimPluginFrom2Nix { name = "vim-polyglot"; src = args.vim-polyglot; }; }
      { plugin = buildVimPluginFrom2Nix { name = "editorconfig.nvim"; src = args.editorconfig-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "vim-edgemotion"; src = args.vim-edgemotion; }; }
      { plugin = buildVimPluginFrom2Nix { name = "nvim-web-devicons"; src = args.nvim-web-devicons; }; }
      {
        plugin = buildVimPluginFrom2Nix { name = "popup.nvim"; src = args.popup-nvim; };
        type = "lua";
        config = ''
          -- Global option
          vim.g.mapleader = " "
          vim.o.encoding = "UTF-8"
          vim.o.swapfile = false
          vim.o.smartindent = true
          vim.o.smarttab = true
          vim.o.visualbell = true
          vim.o.hlsearch = true
          vim.o.signcolumn = "yes"
          vim.o.smartcase = true
          vim.o.ignorecase = true
          vim.o.showmode = true
          vim.o.completeopt = "menuone,noinsert,noselect"
          vim.o.termguicolors = true
          vim.o.background = "dark"
        '';
      }
      { plugin = buildVimPluginFrom2Nix { name = "plenary.nvim"; src = args.plenary-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "nordic.nvim"; src = args.nordic-nvim; }; type = "lua"; config = builtins.readFile ./nordic-nvim.lua; }
      {
        plugin = (pkgs.vimPlugins.nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars));
        type = "lua";
        config = builtins.readFile ./nvim-treesitter.lua;
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "nvim-treesitter-context"; src = args.nvim-treesitter-context; };
        type = "lua";
        config = ''require("treesitter-context").setup({ enable = true, throttle = true })'';
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "telescope.nvim"; src = args.telescope-nvim; };
        type = "lua";
        config = builtins.readFile ./telescope-nvim.lua;
      }
      {
        plugin = buildVimPlugin { name = "telescope-fzf-native.nvim"; src = args.telescope-fzf-native-nvim; };
        type = "lua";
        config = ''require("telescope").load_extension("fzf")'';
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "telescope-ghq.nvim"; src = args.telescope-ghq-nvim; };
        type = "lua";
        config = ''require("telescope").load_extension("ghq")'';
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "telescope-command-palette.nvim"; src = args.telescope-command-palette-nvim; };
        type = "lua";
        config = ''require("telescope").load_extension("command_palette")'';
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "lualine.nvim"; src = args.lualine-nvim; };
        type = "lua";
        config = ''require("lualine").setup({ options = { theme = "nord" } })'';
      }
      { plugin = buildVimPluginFrom2Nix { name = "cmp-nvim-lsp"; src = args.cmp-nvim-lsp; }; }
      { plugin = buildVimPluginFrom2Nix { name = "cmp-buffer"; src = args.cmp-buffer; }; }
      { plugin = buildVimPluginFrom2Nix { name = "cmp-cmdline"; src = args.cmp-cmdline; }; }
      {
        plugin = buildVimPluginFrom2Nix { name = "nvim-cmp"; src = args.nvim-cmp; };
        type = "lua";
        config = builtins.readFile ./nvim-cmp.lua;
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "lsp-format.nvim"; src = args.lsp-format-nvim; };
        type = "lua";
        config = builtins.readFile ./lsp-format-nvim.lua;
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "nvim-lspconfig"; src = args.nvim-lspconfig; };
        type = "lua";
        config = builtins.readFile ./nvim-lspconfig.lua;
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "which-key.nvim"; src = args.which-key-nvim; };
        type = "lua";
        config = ''
          local wk = require("which-key")
          wk.setup({
            window = {
              border = "double",
            },
          })
          wk.register({
            ["C-p"] = { '<cmd>lua require"telescope".extensions.command_palette.command_palette({})<CR>'}
          })
        '';
      }
      {
        plugin = buildVimPluginFrom2Nix { name = "nvim-notify"; src = args.nvim-notify; };
        type = "lua";
        config = ''vim.notify = require("notify")'';
      }
    ];

    extraConfig = ''
      lua <<EOF
    '' + builtins.readFile ./init.lua + "EOF";
  };
}
