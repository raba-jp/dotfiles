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
          name = "vim-jetpack";
          src = inputs.vim-jetpack;
        };
      }
    ];

    extraConfig =
      "lua <<EOF"
      + (builtins.readFile ./init.lua)
      + "EOF";
  };
}
