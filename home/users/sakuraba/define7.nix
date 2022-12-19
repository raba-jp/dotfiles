{...}: {
  imports = [
    ../../features/cli.nix
    ../../features/espanso.nix
    ../../features/fish.nix
    ../../features/fzf.nix
    ../../features/git.nix
    ../../features/gitui.nix
    ../../features/helix.nix
    ../../features/wezterm
    ../../features/starship.nix
  ];

  home.stateVersion = "22.11";
}
