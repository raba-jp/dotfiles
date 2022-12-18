{inputs, ...}: {
  programs.bat = {
    enable = true;
    themes = builtins.readFile (inputs.catppuccin-bat + "/Catppuccin-mocha.tmTheme");
  };
}
