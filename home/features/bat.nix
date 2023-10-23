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
      Catppuccin-mocha = {
        src = inputs.catppuccin-bat;
        file = "Catppuccin-mocha.tmTheme";
      };
    };

    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };
}
