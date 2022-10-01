{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    {
      dotfiles = {
        amd.enable = true;
        docker.enable = false;
        game.enable = false;
        gnome.enable = true;
        nextdns = {
          enable = false;
        };
        trackpad.enable = true;
        lxqt.enable = false;
        physical = {
          enable = true;
          boot.loader.useDefault = true;
          kernelPackages = pkgs.linuxPackages_5_19;
        };
      };
    }
  ];

  networking.hostName = "xps13";

  hardware.enableRedistributableFirmware = true;
  boot.blacklistedKernelModules = ["psmouse"];
  services.fwupd.enable = true;

  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
      config.users.groups.keys.name
    ];
    hashedPassword = "$6$pfJbTwMjGKRLZED.$E7VDlAVGg75bOgdnEo11Q9GCHH0M0RQk3VXlTotAxsE0EpypbiOAWbe8AsdwtgDCPbBtrSQ5zqrqYyX28qAO9.";
  };

  home-manager.users.sakuraba = {
    imports = [
      ../../home-manager/minimal.nix
      ../../home-manager/base.nix
      ../../home-manager/extends.nix
      ../../home-manager/kubernetes.nix
      ../../home-manager/linux.nix
      ../../home-manager/gtk
      ../../home-manager/dconf
      ../../home-manager/fish
      ../../home-manager/fzf
      ../../home-manager/git
      ../../home-manager/starship
      ../../home-manager/tig
      ../../home-manager/wezterm
      ../../home-manager/helix
    ];
  };
}
