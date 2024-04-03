{pkgs, ...}: {
  home = {
    sessionVariables = {
      PAGER = "bat";
    };

    packages = with pkgs; [
      ripgrep
      procs
      ghq
      gh
      nil
      mise
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza.enable = true;

    home-manager.enable = true;
  };
}
