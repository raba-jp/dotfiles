{
  pkgs,
  inputs,
  ...
}: {
  programs.bat = {
    enable = true;

    config = {
      theme = "Catppuccin-mocha";
      style = "changes,header";
    };

    themes = {
      Catppuccin-mocha = builtins.readFile (inputs.catppuccin-bat + "/Catppuccin-mocha.tmTheme");
    };

    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };
}
