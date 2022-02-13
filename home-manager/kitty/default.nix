{ pkgs, ... }: {
  imports = [ ./keybindings.nix ./settings.nix ];
  programs.kitty = {
    enable = false;

    font = {
      package = pkgs.cica;
      name = "Cica";
      size = (if pkgs.stdenvNoCC.isDarwin then 16 else 12);
    };
  };
}
