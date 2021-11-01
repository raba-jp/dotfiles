{ inputs, config, pkgs, ... }:
{
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
    package = pkgs.nixUnstable;

    allowedUsers = [ "sakuraba" ];
    trustedUsers = [ "sakuraba" ];

    maxJobs = 8;
    buildCores = 8;
  };


  users.nix.configureBuildUsers = true;
  services.nix-daemon.enable = true;

  system.stateVersion = 4;

  nixpkgs.config.allowUnfree = true;
}
