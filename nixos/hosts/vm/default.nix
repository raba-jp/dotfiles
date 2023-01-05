{
  pkgs,
  modulePath,
  ...
}: {
  imports = [
    ../../common/global
    ../../common/optional/systemd-boot.nix
    ../../common/optional/hyprland.nix
    ../../common/users/sakuraba.nix
  ];

  networking.hostName = "vm";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    libnotify
    virt-manager
  ];
}
