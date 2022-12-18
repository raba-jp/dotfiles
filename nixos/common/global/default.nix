{
  pkgs,
  outputs,
  ...
}: {
  imports =
    [
      ./home-manager.nix

      ./locale.nix
      ./nix.nix
      ./nixpkgs.nix
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
}
