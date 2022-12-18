{
  pkgs,
  inputs,
  ...
}: {
  programs.gitui = {
    enable = true;

    theme = builtins.readFile (inputs.catppuccin-gitui + "/theme/mocha.ron");
  };
}
