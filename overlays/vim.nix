final: prev:
{
  vimPlugins = prev.vimPlugins // {
    vim-edgemotion = prev.pkgs.vimUtils.buildVimPlugin {
      name = "vim-edgemotion";

      src = prev.pkgs.fetchFromGitHub {
        owner = "haya14busa";
        repo = "vim-edgemotion";
        rev = "8d16bd92f6203dfe44157d43be7880f34fd5c060";
        sha256 = "1w3nqkw7k2ryrw1rckj27a0jbjnvgc6fb7871fhb4ba2mpxd8l08";
      };
    };

    format-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "format.nvim";

      src = prev.pkgs.fetchFromGitHub {
        owner = "lukas-reineke";
        repo = "format.nvim";
        rev = "c46ab8b46100e26fce4d6ce69a94d4cea8b9f4d7";
        sha256 = "fYyUStur+cCKx2uDdrsCBct1/xDTIOaxAkm8RwZMuFg=";
      };
    };

    nordic-nvim = prev.pkgs.vimUtils.buildVimPlugin {
      name = "nordic.nvim";

      src = prev.pkgs.fetchFromGitHub {
        owner = "andersevenrud";
        repo = "nordic.nvim";
        rev = "6c19b29aa3e09687ee6d0f6d6eef2644ef39f690";
        sha256 = "ILldqjSjhDO8me+ZaPkLuo1eoyF19RiQ6Eb09jBSaZA=";
      };
    };
  };
}
