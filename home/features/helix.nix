{pkgs, outputs,...}:{
  programs.helix = {
    enable = true;
    package = outputs.packages.${pkgs.system}.helix;
    defaultEditor = true;
    settings = {
      theme = "rose_pine_moon";
    };
  };
}
