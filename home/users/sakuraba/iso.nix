{...}: {
  imports = [
    ../features/espanso.nix
    ../features/fish.nix
    ../features/fzf.nix
    ../features/git.nix
    ../features/gitui.nix
    ../features/helix.nix
    ../features/hyprland.nix
    ../features/starship.nix
  ];

  home.stateVersion = "22.11";
}
