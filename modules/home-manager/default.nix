{ pkgs, ... }: {
  imports = [
    ./home.nix
    ./packages.nix
    ./xdg.nix
    ./fish.nix
    ./tmux.nix
    ./alacritty.nix
    ./git.nix
    ./vim
    ./kitty.nix
    ./zsh.nix
    # ./hammerspoon # Enabled for only darwin
    # ./nixos.nix # Enabled for only linux
  ];
}
