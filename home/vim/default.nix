{ pkgs, ... }: 

let
  nixosUnstable = import <nixos-unstable> {};

  customPlugins = import ./plugins.nix { inherit pkgs; };

  plugins = pkgs.vimPlugins // customPlugins;
  vimConfig = builtins.readFile ./config.vim;
  neovimConfig = builtins.readFile ./init.lua;
in
{
  home.packages = with pkgs; [
    gcc
    tree-sitter
  ];
  programs.vim = {
    enable = true;

    plugins = with plugins; [
      vim-polyglot
      lightline-vim
      editorconfig-vim
      ctrlp-vim
      vim-edgemotion
      fern-vim
      vim-solarized8
    ];
    extraConfig = vimConfig;
  };

  programs.neovim = {
    enable = true;

    package = nixosUnstable.neovim-unwrapped;

    viAlias = false;
    vimAlias = false;
    vimdiffAlias = false;

    plugins = with plugins; [
      vim-polyglot
      editorconfig-vim
      vim-edgemotion
      nvim-treesitter
      vim-solarized8
    ];

    extraConfig = "lua <<EOF\n" + neovimConfig + "\nEOF";
  };
}
