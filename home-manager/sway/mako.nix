{ config, ... }: {
  programs.mako = {
    enable = true;
    anchor = "bottom-right";
    backgroundColor = "#3b4252";
    borderColor = "#81a1c1";

    extraConfig = ''
      [urgency=high]
      border-color=#d08770
      border-size=3
      default-timeout=0
    '';

    defaultTimeout = 3000;
    font = "UDEV Gothic 12";
    height = 150;
    ignoreTimeout = true;
    maxVisible = -1;
    progressColor = "over #88c0d0";
    textColor = "#eceff4";
  };
}
