{ pkgs, ... }: {
  imports = [
    ./homebrew.nix
    ./yabai.nix
    ./skhd.nix
  ];

  environment.pathsToLink = [ "/Applications" ];

  services = {
    cachix-agent = {
      enable = true;
      name = config.networking.hostName;
      credentialsFile = "/var/secrets/cachix-agent-token";
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [ cica udev-gothic udev-gothic-nf ];
  };

  nix = {
    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "@wheel" ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    package = pkgs.nix;

    binaryCaches = [
      "https://raba-jp.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    binaryCachePublicKeys = [
      "raba-jp.cachix.org-1:NgVIMhL5fUaEclOsEtMnCBbyrYDG+qvPPldf2pqklu8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };
  };

  users.nix.configureBuildUsers = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
