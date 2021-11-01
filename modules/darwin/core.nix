{ inputs, config, pkgs, ... }: {
  environment = {
    pathsToLink = [ "/Applications" ];

    systemPackages = with pkgs; [ vim ];
  };

  nix = {
    allowedUsers = [ "sakuraba" ];
    trustedUsers = [ "sakuraba" ];
  };

  fonts.fonts = with pkgs; [ cica ];

  users.nix.configureBuildUsers = true;
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
