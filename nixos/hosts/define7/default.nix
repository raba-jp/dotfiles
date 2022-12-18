{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/global
    ../../common/optional/gnome.nix
    ../../common/optional/gamemode.nix
    ../../common/optional/pipewire.nix
    ../../common/optional/systemd-boot.nix
  ];

  boot.initrd.kernelModules = ["amdgpu"];

  services.xserver.videoDrivers = ["amdgpu"];

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
    gnome.gnome-boxes
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
