{pkgs, ...}: {
  imports = [
    ../../common/global
    ../../common/optional/hyprland.nix
    ../../common/users/sakuraba.nix
  ];

  networking.hostName = "iso";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = ["aarch64-linux"];
  };

  system.stateVersion = "22.11";
}
