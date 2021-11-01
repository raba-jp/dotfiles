{ inputs, config, pkgs, ... }: {
  environment = {
    loginShell = pkgs.zsh;
    pathsToLink = [ "/Applications" ];

    systemPackages = with pkgs; [ vim ];
  };

  programs.zsh.enable = true;

  fonts = {
    enableFontDir = true;
    fonts = [ ];
  };

  nix = {
    allowedUsers = [ "sakuraba" ];
    trustedUsers = [ "sakuraba" ];
  };

  users.nix.configureBuildUsers = true;
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
