{ pkgs, ... }: {
  imports = [
    ./core.nix
    ./homebrew.nix
    ./preferences.nix
  ];
}
