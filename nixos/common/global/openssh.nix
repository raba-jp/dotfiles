{
  services.openssh = {
    enable = true;
  };
  programs.ssh.startAgent = false;
}
