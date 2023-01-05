{...}: {
  services.openssh = {
    enable = true;

    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "no";
    gatewayPorts = "clientspecified";
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
  };

  security.pam.enableSSHAgentAuth = true;
}
