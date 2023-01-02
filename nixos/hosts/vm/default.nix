{pkgs, ...}: {
  imports = [
    ../../common/global
    ../../common/users/sakuraba.nix
  ];

  networking.hostName = "vm";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    libnotify
    virt-manager
  ];
}
