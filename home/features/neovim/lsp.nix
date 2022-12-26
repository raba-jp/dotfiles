{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
in [
  {
    plugin = buildVimPluginFrom2Nix {
      name = "nvim-lspconfig";
      src = inputs.nvim-lspconfig;
    };
  }
  {
    plugin = buildVimPluginFrom2Nix {
      name = "nvim-cmp";
      src = inputs.nvim-cmp;
    };
  }
  {
    plugin = buildVimPluginFrom2Nix {
      name = "cmp-nvim-lsp";
      src = inputs.cmp-nvim-lsp;
    };
  }
  {
    plugin = buildVimPluginFrom2Nix {
      name = "cmp-buffer";
      src = inputs.cmp-buffer;
    };
  }
  {
    plugin = buildVimPluginFrom2Nix {
      name = "cmp-path";
      src = inputs.cmp-path;
    };
  }
  {
    plugin = buildVimPluginFrom2Nix {
      name = "cmd-cmdline";
      src = inputs.cmp-cmdline;
    };
  }
  {
    plugin = buildVimPluginFrom2Nix {
      name = "vim-vsnip";
      src = inputs.vim-vsnip;
    };
  }
]
