{
  pkgs,
  outputs,
  ...
}: {
  imports =
    [
      ../../../shared/common/global/nix.nix
      ../../../shared/common/global/nixpkgs.nix

      ./home-manager.nix
      ./locale.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  environment = {
    enableAllTerminfo = true;

    systemPackages = with pkgs; [
      appimagekit
      appimage-run
      libnotify
      lm_sensors
    ];
  };

  system = {
    autoUpgrade.enable = true;

    stateVersion = "21.11";
  };
}
