{ buildVimPlugin, fetchFromGitHub }: {
  vim-edgemotion = buildVimPlugin {
    name = "vim-edgemotion";

    src = fetchFromGitHub {
      owner = "haya14busa";
      repo = "vim-edgemotion";
      rev = "8d16bd92f6203dfe44157d43be7880f34fd5c060";
      sha256 = "1w3nqkw7k2ryrw1rckj27a0jbjnvgc6fb7871fhb4ba2mpxd8l08";
    };
  };

  asyncomplete-lsp-vim = buildVimPlugin {
    name = "asyncomplete-lsp-vim";

    src = fetchFromGitHub {
      owner = "prabirshrestha";
      repo = "asyncomplete-lsp.vim";
      rev = "684c34453db9dcbed5dbf4769aaa6521530a23e0";
      sha256 = "0vqx0d6iks7c0liplh3x8vgvffpljfs1j3g2yap7as6wyvq621rq";
    };
  };

  vim-lsp-settings = buildVimPlugin {
    name = "vim-lsp-settings";

    src = fetchFromGitHub {
      owner = "mattn";
      repo = "vim-lsp-settings";
      rev = "609c40d4947c762bbe9009b8bcd89e2c83be1dad";
      sha256 = "1awbmrkkwyrs0sligynanw0sq9rnd2mpnxymhkx7awjh65j5wnaz";
    };
  };

  fern-vim = buildVimPlugin {
    name = "fern-vim";

    src = fetchFromGitHub {
      owner = "lambdalisue";
      repo = "fern.vim";
      rev = "v1.37.0";
      sha256 = "1prl720r82mp89jfciw50pd2cygp97v46w7vq30b1m4v3016lh15";
    };
  };

  vim-solarized8 = buildVimPlugin {
    name = "vim-soalized8";

    src = fetchFromGitHub {
      owner = "lifepillar";
      repo = "vim-solarized8";
      rev = "v1.2.0";
      sha256 = "1kb9ma1j0ijsvikzypc2dwdkrp5xy1cwcqs8gdz53n35kragfc9c";
    };
  };
}
