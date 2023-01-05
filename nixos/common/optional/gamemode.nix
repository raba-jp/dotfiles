{
  programs = {
    gamemode = {
      enable = true;

      settings = {
        general = {
          softrealtime = "on";
          inhibit_screensaver = 1;
        };

        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          amd_performance_level = "high";
        };
      };
    };
    steam.enable = true;
  };

  services.factorio = {
    enable = true;
    public = false;
  };

  networking = {
    firewall = {
      allowedTCPPorts = [34197];
      allowedUDPPorts = [34197];
    };
  };
}
