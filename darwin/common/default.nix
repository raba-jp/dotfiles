{...}: {
  imports = [
    ./nix.nix
    ./nixpkgs.nix
    ./home-manager.nix
    ./homebrew.nix
    ./defaults.nix
  ];

  environment.pathsToLink = ["/Applications"];

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

  documentation.enable = false;

  system.stateVersion = 4;
}
