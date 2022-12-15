{
  pkgs,
  outputs,
  ...
}: {
  imports =
    [
      ./home-manager.nix

      ./docker.nix
      ./locale.nix
      ./nix.nix
      ./nixpkgs.nix
      ./openssh.nix
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
