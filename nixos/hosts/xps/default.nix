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
    inputs.impermanence.nixosModules.impermanence
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

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
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

    disko.devices = pkgs.callPackage ./disk.nix {};

    persistence."/persistent" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          parentDirectory = {mode = "u=rwx,g=,o=";};
        }
      ];
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
