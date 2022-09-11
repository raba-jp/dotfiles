{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotfiles.desktop;
in {
  imports = [
    ./gnome.nix
    ./lxqt.nix
  ];

  options.dotfiles.desktop = {
  };

  config = {
    services = {
      xserver = {
        layout = "us";
        xkbOptions = "ctrl:nocaps";
      };

      openssh.enable = true;

      udev.extraRules = ''
        KERNEL=="hidraw*", ATTRS{idVendor}=="bb01", MODE="0664", GROUP="users"
        KERNEL=="hidraw*", ATTRS{idVendor}=="4653", MODE="0664", GROUP="users"
      '';
    };

    programs = {
      gnupg.agent.enable = true;

      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = ["sakuraba"];
      };
    };

    environment.systemPackages = with pkgs; [
      google-chrome
      sidekick
      logseq
      vscode
      papirus-icon-theme
      nordic
      materia-theme
      papirus-icon-theme
      nordzy-cursor-theme
      xclip
      libnotify
      lm_sensors
      gparted
      flatpak
      lutris
      bottles
      appimagekit
      appimage-run
    ];
  };
}
