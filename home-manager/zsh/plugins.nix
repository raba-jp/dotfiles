{ pkgs, ... }: {
  programs.zsh.plugins = [{
    name = "";
    src = pkgs.fetchFromGitHub {
      owner = "mollifier";
      repo = "anyframe";
      rev = "598675303044df8e9d04722f3adff4f63a238922";
      sha256 = "WaBaxxQzwpIlsfTgWGt8GSQin6nbm45mRvtW0VqociE=";
    };
  }];
}
