# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  # Include the results of the hardware scan.
    <home-manager/nixos>
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/boot.nix
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/networking.nix
    /home/sakuraba/ghq/github.com/raba-jp/dotfiles/nixos/localize.nix
  ];

  nixpkgs.overlays =
    import /home/sakuraba/ghq/github.com/raba-jp/dotfiles/overlays;

  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sakuraba = {
    isNormalUser = true;
    createHome = true;
    home = "/home/sakuraba";
    extraGroups =
      [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.sakuraba = { pkgs, ... }: {

    imports = [ /home/sakuraba/ghq/github.com/raba-jp/dotfiles/home-manager/home.nix ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    firefox
    alacritty
    google-chrome
    git
    tmux
    vscode
    arc-theme
    gnome.gnome-tweaks
    materia-theme
    ghq
    ripgrep
    gitAndTools.tig
    starship
    fish
    obsidian
    libnotify
  ];

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

}

