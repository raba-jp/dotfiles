{ pkgs, ... }:
let
  starship = pkgs.callPackage ./patch.nix {
    inherit (pkgs.darwin.apple_sdk.frameworks) Security;
  };
in
{

  programs.starship = {
    enable = true;
    package = starship;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
