{ inputs, config, pkgs, ... }: {
  imports = [ ./nixpkgs.nix ];

  fonts.enableFontDir = true;
}
