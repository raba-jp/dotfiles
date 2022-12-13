{pkgs, ...}: {
  imports = [
    ../common/global
    ../common/users/sakuraba.nix
  ];

  networking.hostName = "vm";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_latest;
    binfmt.emulatedSystems = ["aarch64-linux"];
  };

  system.stateVersion = "22.11";
}
