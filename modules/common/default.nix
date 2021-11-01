{ inputs, config, pkgs, ... }: {
  imports = [ ./nixpkgs.nix ];

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-emoji cica ];
  };
}
