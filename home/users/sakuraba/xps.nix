{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ../../features/wezterm
    ../../features/neovim

    ../../features/bat.nix
    ../../features/cli.nix
    ../../features/espanso.nix
    ../../features/fish.nix
    ../../features/fzf.nix
    ../../features/git.nix
    ../../features/gitui.nix
    ../../features/helix.nix
    ../../features/starship.nix
    ../../features/hyprland.nix
    ../../features/waybar.nix
  ];

  programs.git.extraConfig = {
    user.signingKey = "/home/sakuraba/.ssh/id_ed25519.pub";
    gpg.ssh.allowedSignersFile = "/home/sakuraba/.ssh/id_ed25519";
    commit.gpgsign = true;
  };

  home = {
    persistence."/nix/persist/home/sakuraba" = {
      directories = [
        "ghq"
        "dotfiles"
        "go"
        "pCloud"
        "Downloads"
        "Games"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".aws"
        ".cache"
        ".local"
        ".factorio"
        ".gnupg"
        ".mozc"
        ".ssh"
        ".steam"
        ".wine"
      ];

      files = [];

      allowOther = true;
    };

    stateVersion = "22.11";
  };
}
