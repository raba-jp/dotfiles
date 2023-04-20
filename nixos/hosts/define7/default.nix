{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    ./hardware-configuration.nix
    ../../common/global
    ../../common/optional/gnome.nix
    ../../common/optional/gamemode.nix
    ../../common/optional/pipewire.nix
    ../../common/optional/systemd-boot.nix
    ../../common/optional/cachix.nix
    ../../common/optional/libvirtd.nix
    ../../common/optional/network-manager.nix
    ../../common/optional/yubikey.nix
    ../../common/optional/qmk.nix
    # ../../common/optional/hyprland.nix
    # ../../common/optional/nm-applet.nix
    # ../../common/optional/blueman.nix
    ../../common/users/sakuraba.nix
  ];

  networking.hostName = "define7";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.kernelModules = ["amdgpu"];

  services = {
    xserver.videoDrivers = ["amdgpu"];

    udev.extraRules = ''
      KERNEL=="hidraw*", ATTRS{idVendor}=="bb01", MODE="0664", GROUP="users"
      KERNEL=="hidraw*", ATTRS{idVendor}=="4653", MODE="0664", GROUP="users"
      KERNEL=="hidraw*", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0181", TAG+="uaccess", MODE="0664", GROUP="users"
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
    extraPackages = with pkgs; [amdvlk];
    extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
  };
}
