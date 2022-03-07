{ lib, pkgs, ... }: {
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

    plugins = with pkgs.vimPlugins; [
      vim-polyglot
      editorconfig-nvim
      vim-edgemotion
      nvim-web-devicons
      {
        plugin = popup-nvim;
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
      { plugin = plenary-nvim; }
      {
        plugin = nordic-nvim;
        type = "lua";
        config = builtins.readFile ./nordic-nvim.lua;
      }
      {
        plugin = (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars));
        type = "lua";
        config = builtins.readFile ./nvim-treesitter.lua;
      }
      {
        plugin = nvim-treesitter-context;
        type = "lua";
        config = ''require("treesitter-context").setup({ enable = true, throttle = true })'';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./telescope-nvim.lua;
      }
      {
        plugin = telescope-fzf-native-nvim;
        type = "lua";
        config = ''require("telescope").load_extension("fzf")'';
      }
      {
        plugin = telescope-ghq-nvim;
        type = "lua";
        config = ''require("telescope").load_extension("ghq")'';
      }
      {
        plugin = telescope-command-palette-nvim;
        type = "lua";
        config = ''require("telescope").load_extension("command_palette")'';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''require("lualine").setup({ options = { theme = "nord" } })'';
      }
      { plugin = cmp-nvim-lsp; }
      { plugin = cmp-buffer; }
      { plugin = cmp-cmdline; }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./nvim-cmp.lua;
      }
      {
        plugin = lsp-format-nvim;
        type = "lua";
        config = builtins.readFile ./lsp-format-nvim.lua;
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./nvim-lspconfig.lua;
      }
      {
        plugin = which-key-nvim;
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
        plugin = nvim-notify;
        type = "lua";
        config = ''vim.notify = require("notify")'';
      }
    ];

    extraConfig = ''
      lua <<EOF
    '' + builtins.readFile ./init.lua + "EOF";
  };
}
