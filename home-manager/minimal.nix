{pkgs, ...}: {
  home = {
    stateVersion = "22.05";

    packages = with pkgs; [
      unzip
      nkf
      killall
      gnupg
      envsubst
    ];
  };

  programs.home-manager.enable = true;
}
