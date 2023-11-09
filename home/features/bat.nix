{pkgs, ...}: {
  programs.bat = {
    enable = true;

    config = {
      style = "changes,header";
    };

    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };
}
