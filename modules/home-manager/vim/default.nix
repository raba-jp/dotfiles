{ pkgs, ... }:

let
  customPlugins = import ./plugins.nix { inherit pkgs; };

  plugins = pkgs.vimPlugins // customPlugins;
  vimConfig = builtins.readFile ./config.vim;
  neovimConfig = builtins.readFile ./init.lua;
in {
  home.packages = with pkgs; [ gcc tree-sitter gopls rust-analyzer ];
  programs.vim = {
    enable = true;

    plugins = with plugins; [
      vim-polyglot
      lightline-vim
      editorconfig-vim
      ctrlp-vim
      vim-edgemotion
      fern-vim
      nord-vim
    ];
    extraConfig = vimConfig;
  };

  programs.neovim = {
    enable = true;

    package = pkgs.neovim-unwrapped;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with plugins; [
      vim-polyglot
      editorconfig-vim
      vim-edgemotion
      nvim-treesitter
      nord-vim

      popup-nvim
      plenary-nvim
      telescope-nvim # depends on popup-nvim, plenary-nvim

      lualine-nvim

      nvim-lspconfig
      nvim-compe
      lspsaga-nvim

      format-nvim
    ];

    extraConfig = ''
      lua <<EOF
    '' + neovimConfig + ''

      EOF'';
  };
}