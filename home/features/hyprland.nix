{inputs, ...}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig =
      ''

      ''
      + builtins.readFile (inputs.catppuccin-hyprland + "/themes/mocha.conf");
  };
}
