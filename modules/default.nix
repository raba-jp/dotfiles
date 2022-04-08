{ pkgs, ... }: {
  imports = [
    ./factorio-server.nix
    ./game.nix
    ./graphical.nix
    ./nvidia.nix
    ./amd.nix
    ./docker.nix
  ];
}
