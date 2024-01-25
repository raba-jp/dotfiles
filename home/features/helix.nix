{pkgs, outputs,...}:{
  programs.helix = {
    enable = true;
    package = outputs.packages.${pkgs.system}.helix;
    defaultEditor = true;
    settings = {
    };
  };
}
