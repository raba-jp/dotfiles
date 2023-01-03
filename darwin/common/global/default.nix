{...}: {
  imports = [
    ../../../shared/common/global/nix.nix
    ../../../shared/common/global/nixpkgs.nix
  ];

  environment.pathsToLink = ["/Applications"];

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
