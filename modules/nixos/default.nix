{pkgs, ...}: {
  imports = [
    ./amd.nix
    ./docker.nix
    ./game.nix
    ./gnome.nix
    ./nextdns.nix
    ./physical.nix
    ./trackpad.nix
    ./lxqt.nix
  ];

  i18n = {
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [mozc];
      # fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    };
  };

  services.xserver = {
    layout = "us";
    xkbOptions = "ctrl:nocaps";
  };

  nix = {
    settings = {
      trusted-users = ["root" "@wheel"];
      substituters = [
        "https://raba-jp.cachix.org"
        "https://helix.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    package = pkgs.nix;

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [cachix];

  nixpkgs = {
    config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };
  };

  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.11";
  };
}
