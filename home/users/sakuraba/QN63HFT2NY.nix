{...}: {
  imports = [
    ../../features/wezterm
    ../../features/neovim

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

  programs.git.extraConfig = {
    user.signingKey = "/Users/sakuraba/.ssh/id_ed25519.pub";
    gpg.ssh.allowedSignersFile = "/Users/sakuraba/.ssh/id_ed25519";
    commit.gpgsign = true;
  };

  home.stateVersion = "23.05";

  manual.manpages.enable = false;
}
