{ pkgs }: {
  vim-edgemotion = pkgs.vimUtils.buildVimPlugin {
    name = "vim-edgemotion";

    src = pkgs.fetchFromGitHub {
      owner = "haya14busa";
      repo = "vim-edgemotion";
      rev = "8d16bd92f6203dfe44157d43be7880f34fd5c060";
      sha256 = "1w3nqkw7k2ryrw1rckj27a0jbjnvgc6fb7871fhb4ba2mpxd8l08";
    };
  };

  asyncomplete-lsp-vim = pkgs.vimUtils.buildVimPlugin {
    name = "asyncomplete-lsp-vim";

    src = pkgs.fetchFromGitHub {
      owner = "prabirshrestha";
      repo = "asyncomplete-lsp.vim";
      rev = "684c34453db9dcbed5dbf4769aaa6521530a23e0";
      sha256 = "0vqx0d6iks7c0liplh3x8vgvffpljfs1j3g2yap7as6wyvq621rq";
    };
  };

  vim-lsp-settings = pkgs.vimUtils.buildVimPlugin {
    name = "vim-lsp-settings";

    src = pkgs.fetchFromGitHub {
      owner = "mattn";
      repo = "vim-lsp-settings";
      rev = "609c40d4947c762bbe9009b8bcd89e2c83be1dad";
      sha256 = "1awbmrkkwyrs0sligynanw0sq9rnd2mpnxymhkx7awjh65j5wnaz";
    };
  };

  fern-vim = pkgs.vimUtils.buildVimPlugin {
    name = "fern-vim";

    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern.vim";
      rev = "v1.37.0";
      sha256 = "1prl720r82mp89jfciw50pd2cygp97v46w7vq30b1m4v3016lh15";
    };
  };

  format-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "format.nvim";

    src = pkgs.fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "format.nvim";
      rev = "c46ab8b46100e26fce4d6ce69a94d4cea8b9f4d7";
      sha256 = "fYyUStur+cCKx2uDdrsCBct1/xDTIOaxAkm8RwZMuFg=";
    };
  };
}
