{pkgs, ...}: {
  imports = [
    ./nix.nix
    ./nixpkgs.nix
    ./home-manager.nix
    ./homebrew.nix
    ./defaults.nix
  ];

  environment.pathsToLink = ["/Applications"];
  environment.shells = with pkgs; [zsh];

  programs.zsh.enable = true;

  documentation.enable = false;

  system.stateVersion = 6;
}
