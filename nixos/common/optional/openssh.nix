{...}: {
  services.openssh = {
    enable = true;

    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "no";
    gatewayPorts = "clientspecified";
    extraConfig = ''
      StreamLocalBindUnlink yes

      Host eu.nixbuild.net
          PubkeyAcceptedKeyTypes ssh-ed25519
          IdentityFile /etc/ssh/ssh_host_ed25519_key
    '';
  };

  programs.ssh.knownHosts = {
    nixbuild = {
      hostNames = ["eu.nixbuild.net"];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDbwWTEEz4csfPc3aEIvXIewjAQUoI8YgNpFrTJ/0G4";
    };
  };

  security.pam.enableSSHAgentAuth = true;

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = ["benchmark" "big-parallel"];
      }
    ];
  };
}
