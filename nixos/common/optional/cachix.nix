{
  config,
  pkgs,
  ...
}: {
  age.secrets.cachix-agent-token.file = ../../../secrets/cachix-agent-token.age;

  services.cachix-agent = {
    enable = true;
    credentialsFile = config.age.secrets.cachix-agent-token.path;
  };

  environment.systemPackages = with pkgs; [cachix];
}
