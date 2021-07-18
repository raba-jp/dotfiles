{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    extraConfig = ''
      nnoremap ; :
      nnoremap : ;
    '';
  };
}
