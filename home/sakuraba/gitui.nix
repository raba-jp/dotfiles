{pkgs, ...}: {
  programs.gitui = {
    enable = true;

    theme = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/gitui/master/theme/mocha.ron";
      sha256 = "";
    };
  };
}
