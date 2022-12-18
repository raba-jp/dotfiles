{pkgs, ...}: {
  home = {
    sessionPath = ["$HOME/go/bin" "$HOME/.yarn/bin"];
    sessionVariables = {
      EDITOR = "hx";
      PAGER = "bat";
    };

    packages = with pkgs; [
      ripgrep
      fd
      watchman
      rs-git-fsmonitor
      tig
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
      gping
    ];

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
  };
}
