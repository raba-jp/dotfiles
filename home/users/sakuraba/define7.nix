{...}: {
  imports = [
    ../../features/wezterm
    ../../features/neovim

    ../../features/bat.nix
    ../../features/cli.nix
    ../../features/espanso.nix
    ../../features/fish.nix
    ../../features/fzf.nix
    ../../features/git.nix
    ../../features/gitui.nix
    ../../features/starship.nix
    ../../features/fcitx5.nix
    ../../features/xplr.nix
    ../../features/atuin.nix
    ../../features/desktop.nix
  ];

  programs.git.extraConfig = {
    user.signingKey = "/home/sakuraba/.ssh/id_ed25519.pub";
    gpg.ssh.allowedSignersFile = "/home/sakuraba/.ssh/id_ed25519";
    commit.gpgsign = true;
  };

  home.stateVersion = "23.05";
}
