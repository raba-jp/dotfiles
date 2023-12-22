{pkgs, ...}: {
  home = {
    sessionPath = ["$HOME/go/bin" "$HOME/.yarn/bin"];
    sessionVariables = {
      PAGER = "bat";
    };

    packages = with pkgs; [
      ripgrep
      fd
      procs
      ghq
      gh
      any-nix-shell
      nix-prefetch
      nix-prefetch-git
      kubectl
      kubectx
      skaffold
      stern
      terraform
      gnumake
      nil
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza.enable = true;
    go.enable = true;
    jq.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    home-manager.enable = true;
  };
}
