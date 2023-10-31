{pkgs, ...}: {
  home.packages = with pkgs; [
    brave
    obsidian
    gparted
    vscode
    slack
    discord
  ];
}
