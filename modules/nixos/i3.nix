{ pkgs, ... }: {
  services.xserver = {
    desktopManager = { xterm.enable = false; };
    displayManager = { defaultSession = "none+i3"; };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ rofi i3lock i3blocks ];
    };
  };
}
