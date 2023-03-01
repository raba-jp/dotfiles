{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ../../common/global
    ../../common/optional/pipewire.nix
    ../../common/optional/systemd-boot.nix
    ../../common/optional/cachix.nix
    # ../../common/optional/libvirtd.nix
    ../../common/optional/hyprland.nix
    ../../common/optional/nm-applet.nix
    ../../common/optional/blueman.nix
    ../../common/users/sakuraba.nix
  ];

  networking.hostName = "xps";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services = {
    udev.extraRules = ''
      KERNEL=="hidraw*", ATTRS{idVendor}=="bb01", MODE="0664", GROUP="users"
      KERNEL=="hidraw*", ATTRS{idVendor}=="4653", MODE="0664", GROUP="users"
    '';
  };

  environment.systemPackages = with pkgs; [
    glxinfo
    libva-utils
    vulkan-tools
    google-chrome
    obsidian
    vscode
    papirus-icon-theme
    gparted
    flutter
    xclip
    dconf2nix
    libnotify
    lm_sensors
    bottles
    brave
    slack
    discord
    virt-manager
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
