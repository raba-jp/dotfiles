{
  pkgs,
  modulePath,
  ...
}: {
  imports = [
    "${toString modulePath}/profiles/qemu-guest.nix"
    ../../common/global
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
