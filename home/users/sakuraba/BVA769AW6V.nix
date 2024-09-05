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

  programs.git.extraConfig = {
    # user.signingKey = "/Users/sakuraba/.ssh/id_ed25519.pub";
    # gpg.ssh.allowedSignersFile = "/Users/sakuraba/.ssh/id_ed25519";
    # commit.gpgsign = true;
  };

  home.stateVersion = "24.11";
}
