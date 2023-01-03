{inputs, ...}: {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  # services.xserver = {
  #   enable = true;
  #
  #   displayManager = {
  #     gdm.enable = true;
  #
  #     defaultSession = "hyprland";
  #   };
  # };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs.hyprland = {
    enable = true;
  };
}
