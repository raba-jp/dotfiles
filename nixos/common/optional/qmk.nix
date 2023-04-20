{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qmk-udev-rules
  ];

  hardware.keyboard.qmk.enable = true;
}
