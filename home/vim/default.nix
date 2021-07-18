{ pkgs, ... }: 

let
  custom-plugins = pkgs.callPackage ./plugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
    inherit (pkgs) fetchFromGitHub;
  };

  plugins = pkgs.vimPlugins // custom-plugins;
  config = builtins.readFile ./config.vim;
in
{
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
    extraConfig = config;
  };
}
