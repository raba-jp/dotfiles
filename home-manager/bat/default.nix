{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
      style = "changes,header";
    };
  };
}
