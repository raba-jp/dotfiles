{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.agenix.nixosModules.default

      ./age.nix
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

    stateVersion = "21.11";
  };
}
