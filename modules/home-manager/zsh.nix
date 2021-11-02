{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      ls = "exa";
      ll = "exa -alhG";
      cat = "bat";
      grep = "rg";
      find = "fd";
      tree = "exa --tree";
      ps = "procs";
      untar = "tar -xzvf";
      xclip = "xclip -selection clipboard";
    };
  };
}
