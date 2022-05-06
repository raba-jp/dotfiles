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
      nodePackages.yaml-language-server
      rubyPackages.solargraph
      terraform-ls
      efm-langserver
    ];

    plugins = [
      { plugin = buildVimPluginFrom2Nix { name = "vim-polyglot"; src = args.vim-polyglot; }; }
      { plugin = buildVimPluginFrom2Nix { name = "editorconfig.nvim"; src = args.editorconfig-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "vim-edgemotion"; src = args.vim-edgemotion; }; }
      { plugin = buildVimPluginFrom2Nix { name = "nvim-web-devicons"; src = args.nvim-web-devicons; }; }
      { plugin = buildVimPluginFrom2Nix { name = "popup.nvim"; src = args.popup-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "plenary.nvim"; src = args.plenary-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "dressing.nvim"; src = args.dressing-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "nightfox.nvim"; src = args.nightfox-nvim; }; }
      {
        plugin = (pkgs.vimPlugins.nvim-treesitter);
        # plugin = (pkgs.vimPlugins.nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars));
      }
      { plugin = buildVimPluginFrom2Nix { name = "nvim-treesitter-context"; src = args.nvim-treesitter-context; }; }
      { plugin = buildVimPluginFrom2Nix { name = "telescope.nvim"; src = args.telescope-nvim; }; }
      { plugin = buildVimPlugin { name = "telescope-fzf-native.nvim"; src = args.telescope-fzf-native-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "telescope-ghq.nvim"; src = args.telescope-ghq-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "legendary.nvim"; src = args.legendary-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "lualine.nvim"; src = args.lualine-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "LuaSnip"; src = args.luasnip; }; }
      { plugin = buildVimPluginFrom2Nix { name = "cmp_luasnip"; src = args.cmp-luasnip; }; }
      { plugin = buildVimPluginFrom2Nix { name = "cmp-nvim-lsp"; src = args.cmp-nvim-lsp; }; }
      { plugin = buildVimPluginFrom2Nix { name = "cmp-buffer"; src = args.cmp-buffer; }; }
      { plugin = buildVimPluginFrom2Nix { name = "cmp-cmdline"; src = args.cmp-cmdline; }; }
      { plugin = buildVimPluginFrom2Nix { name = "cmp-nvim-lsp-document-symbol"; src = args.cmp-nvim-lsp-document-symbol; }; }
      { plugin = buildVimPluginFrom2Nix { name = "cmp-nvim-lsp-signature-help"; src = args.cmp-nvim-lsp-signature-help; }; }
      { plugin = buildVimPluginFrom2Nix { name = "lspkind-nvim"; src = args.lspkind-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "nvim-cmp"; src = args.nvim-cmp; }; }
      { plugin = buildVimPluginFrom2Nix { name = "lsp-format.nvim"; src = args.lsp-format-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "nvim-lspconfig"; src = args.nvim-lspconfig; }; }
      { plugin = buildVimPluginFrom2Nix { name = "nvim-notify"; src = args.nvim-notify; }; }
      { plugin = buildVimPluginFrom2Nix { name = "gitsigns-nvim"; src = args.gitsigns-nvim; }; }
      { plugin = buildVimPluginFrom2Nix { name = "lspsaga.nvim"; src = args.lspsaga-nvim; }; }
    ];

    extraConfig = ''
      lua <<EOF
    '' + builtins.readFile ./init.lua + "EOF";
  };
}
