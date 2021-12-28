inputs: final: prev:
{
  vimPlugins = prev.vimPlugins // {
    vim-edgemotion = prev.pkgs.vimUtils.buildVimPlugin {
      name = "vim-edgemotion";
      src = inputs.vim-edgemotion;
    };

    format-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "format.nvim";
      src = inputs.format-nvim;
    };

    nordic-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "nordic.nvim";
      src = inputs.nordic-nvim;
    };

    cmp-nvim-lsp = prev.pkgs.vimUtils.buildVimPlugin {
      name = "cmp-nvim-lsp";
      src = inputs.cmp-nvim-lsp;
    };

    lspsaga-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "lspsaga.nvim";
      src = inputs.lspsaga-nvim;
    };
  };
}
