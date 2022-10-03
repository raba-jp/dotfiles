{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    {
      dotfiles = {
        amd.enable = false;
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
        };
      };
    }
  ];

  networking.hostName = "xps13";

  hardware.enableRedistributableFirmware = true;
  boot.blacklistedKernelModules = ["psmouse"];
  services.fwupd.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

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
