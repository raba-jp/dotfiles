{
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
      consoleMode = "auto";
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };
}
