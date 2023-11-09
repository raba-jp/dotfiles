{inputs, ...}: {
  xdg.dataFile."fcitx5/themes/rose-pine-moon" = {
    source = inputs.rose-pine-fcitx5 + "/rose-pine-moon";
  };
  xdg.configFile."fcitx5/conf/classicui.conf" = {
    text = "Theme=rose-pine-moon";
  };
}
