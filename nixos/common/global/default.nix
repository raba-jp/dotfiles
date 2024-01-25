{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      ./nix.nix
      ./nixpkgs.nix
      ./home-manager.nix
      ./locale.nix
      ./networking.nix
      ./gnupg.nix
      ./openssh.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  programs.fuse.userAllowOther = true;

  environment = {
    enableAllTerminfo = true;

    systemPackages = with pkgs; [
      appimagekit
      appimage-run
      libnotify
      lm_sensors
      findex
      inputs.agenix.packages.${system}.default
    ];
  };

  system = {
    autoUpgrade.enable = true;

    stateVersion = "23.11";
  };
}
