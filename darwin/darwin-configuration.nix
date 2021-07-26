{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim nixfmt ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  users.users.sakuraba = {
    name = "sakuraba";
    description = "Sakuraba Hiroki";
  };

  home-manager.users.sakuraba = { pkgs, ... }: {
    imports = [ ../home/home.nix ../home/darwin.nix ];
  };

  system = { stateVersion = 4; };

  nixpkgs.config.allowUnfree = true;
}
