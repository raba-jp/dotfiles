{...}: {
  imports = [
    ../../features/wezterm

    ../../features/bat.nix
    ../../features/cli.nix
    ../../features/fish.nix
    ../../features/fzf.nix
    ../../features/git.nix
    ../../features/starship.nix
    ../../features/xplr.nix
    ../../features/atuin.nix
    ../../features/helix.nix
  ];

  home.stateVersion = "23.05";

  manual.manpages.enable = false;
}
