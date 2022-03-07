{ lib, pkgs, ... }:
let
  neovimConfig = builtins.readFile ./init.lua;
in
{
  home.packages = with pkgs; [
    # tree sitter
    tree-sitter
    # LSP
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

  programs.neovim = {
    enable = true;

    package = pkgs.neovim-unwrapped;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-polyglot
      editorconfig-vim
      vim-edgemotion
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      nvim-treesitter-context

      popup-nvim
      plenary-nvim
      telescope-nvim # depends on popup-nvim, plenary-nvim
      telescope-fzf-native-nvim
      telescope-ghq-nvim
      telescope-command-palette-nvim
      cheatsheet-nvim
      octo-nvim

      lualine-nvim

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      lspsaga-nvim
      lsp-format-nvim

      nordic-nvim
      nvim-web-devicons

      which-key-nvim
      nvim-notify
    ];

    extraConfig = ''
      lua <<EOF
    '' + neovimConfig + "EOF";
  };
}
