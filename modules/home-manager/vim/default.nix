{ pkgs, ... }:
let
  neovimConfig = builtins.readFile ./init.lua;
in
{
  home.packages = with pkgs; [
    # tree sitter
    gcc
    tree-sitter
    # LSP
    gopls
    rust-analyzer
    sumneko-lua-language-server
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
      nvim-treesitter

      popup-nvim
      plenary-nvim
      telescope-nvim # depends on popup-nvim, plenary-nvim
      telescope-ghq-nvim

      lualine-nvim

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      lspsaga-nvim

      format-nvim

      nordic-nvim
      nvim-web-devicons
    ];

    extraConfig = ''
      lua <<EOF
    '' + neovimConfig + "EOF";
  };
}
