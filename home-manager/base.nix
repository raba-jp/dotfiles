{pkgs, ...}: {
  home = {
    sessionPath = ["$GOPATH/bin" "$HOME/.yarn/bin"];
    sessionVariables = {
      EDITOR = "vim";
      PAGER = "bat";
    };

    packages = with pkgs; [
      ripgrep
      fd
      watchman
      rs-git-fsmonitor
      tig
      lazygit
      procs
      ghq
      gh
      any-nix-shell
      nix-prefetch
      nix-prefetch-git
      deadnix
      statix
      rustup
      bitwarden-cli
      doppler
      shellcheck
      selene
      treefmt
      shfmt
      alejandra
      stylua
    ];
  };

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Nord";
        style = "changes,header";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    go = {
      enable = true;
      goPath = "go";
    };

    jq.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}
