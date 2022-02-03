{ pkgs, ... }: {
  imports = [ ./plugins.nix ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    # shellAliases = {
    #   ls = "exa";
    #   ll = "exa -alhG";
    #   cat = "bat";
    #   grep = "rg";
    #   find = "fd";
    #   tree = "exa --tree";
    #   ps = "procs";
    #   untar = "tar -xzvf";
    #   xclip = "xclip -selection clipboard";
    # };

    initExtra = ''
      autoload -Uz anyframe-init
      anyframe-init
      bindkey -d
      bindkey '^A' beginning-of-line
      bindkey '^E' end-of-line
      bindkey '^H' backward-char
      bindkey '^L' forward-char
      bindkey '^G' anyframe-widget-cd-ghq-repository
      bindkey '^R' anyframe-widget-execute-history
      bindkey '^J' down-line-or-search
      bindkey '^K' up-line-or-search
    '';
  };
}
