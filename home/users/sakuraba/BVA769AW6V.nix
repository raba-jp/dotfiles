{...}: {
  imports = [
    ../../features/wezterm

    ../../features/bat.nix
    ../../features/cli.nix
    ../../features/fish.nix
    ../../features/fzf.nix
    ../../features/git.nix
    ../../features/starship.nix
    ../../features/atuin.nix
    ../../features/zed
  ];

  home.stateVersion = "24.11";
}
