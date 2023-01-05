{...}: {
  imports = [
    ./nix.nix
    ./nixpkgs.nix
    ./home-manager.nix
  ];

  environment.pathsToLink = ["/Applications"];

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
