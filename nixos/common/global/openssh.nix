{...}: {
  services.openssh = {
    enable = true;

    passwordAuthentication = false;
    permitRootLogin = "no";
    gatewayPorts = "clientspecified";
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
  };

  security.pam.enableSSHAgentAuth = true;
}
