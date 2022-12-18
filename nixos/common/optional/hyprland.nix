{inputs, ...}: {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
  };

  services.xserver = {
    enable = true;

    displayManager = {
      gdm.enable = true;

      defaultSession = "hyprland";
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
