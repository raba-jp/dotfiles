{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./yabai.nix
    ./skhd.nix
  ];

  environment.pathsToLink = ["/Applications"];

  services = {
    cachix-agent = {
      enable = true;
      name = config.networking.hostName;
      credentialsFile = "/var/secrets/cachix-agent-token";
    };
  };

  programs.zsh.enable = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [];
  };

  nix = {
    settings = {
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
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
    configureBuildUsers = true;

    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 7d";
    # };

    package = pkgs.nix;

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;

      permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };
  };

  environment.systemPackages = with pkgs; [cachix];

  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
