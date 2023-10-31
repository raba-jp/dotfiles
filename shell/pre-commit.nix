{pkgs, ...}: {
  pre-commit.hooks = {
    gofmt.enable = true;

    alejandra.enable = true;
    deadnix.enable = true;
    stylua.enable = true;
    shfmt.enable = true;
    actionlint.enable = true;
    gitleaks = {
      enable = true;
      name = "gitleaks";
      entry = "${pkgs.gitleaks}/bin/gitleaks detect --no-git --source . -v";
    };
  };
}
