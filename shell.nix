{
  pkgs,
  shellHook,
  ...
}:
pkgs.mkShell {
  inherit shellHook;

  packages = with pkgs; [
    treefmt
    deadnix
    alejandra
    stylua
    shfmt
    taplo
    go
    gitleaks
  ];
}
