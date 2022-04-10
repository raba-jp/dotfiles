{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "instance-20220222-0117";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP2nVyYtM1rQY11FnBGbQkH3+S3S6AGam0I8odOhI27h sakuraba@define7"
  ];
  services.mackerel-agent = {
    enable = true;
    runAsRoot = true;
    apiKeyFile = "/run/keys/mackerel-api-key";
  };
}

