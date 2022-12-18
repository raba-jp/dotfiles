{pkgs, ...}: {
  services.cachix-agent = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [cachix];
}
