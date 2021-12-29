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

    cmp-buffer = prev.pkgs.vimUtils.buildVimPlugin {
      name = "cmp-buffer";
      src = inputs.cmp-buffer;
    };

    lspsaga-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "lspsaga.nvim";
      src = inputs.lspsaga-nvim;
    };

    telescope-ghq-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "telescope-ghq.nvim";
      src = inputs.telescope-ghq-nvim;
    };

    nvim-web-devicons = prev.pkgs.vimUtils.buildVimPlugin {
      name = "nvim-web-devicons";
      src = inputs.nvim-web-devicons;
    };

    which-key-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "which-key.nvim";
      src = inputs.which-key-nvim;
    };

    telescope-command-palette-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "telescope-command-palette.nvim";
      src = inputs.telescope-command-palette-nvim;
    };

    cheatsheet-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "cheatsheet.nvim";
      src = inputs.cheatsheet-nvim;
    };

    octo-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "octo.nvim";
      src = inputs.octo-nvim;
    };
  };
}
