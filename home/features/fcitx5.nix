{inputs, ...}: {
  xdg.dataFile."fcitx5/themes/catppuccin-mocha" = {
    source = inputs.catppuccin-fcitx5 + "/src/catppuccin-mocha";
  };
  xdg.configFile."fcitx5/conf/classicui.conf" = {
    text = "Theme=catppuccin-mocha";
  };
}
