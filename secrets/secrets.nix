let
  sakuraba_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIO3XXec588RHW99sDhZjQoWs4OzexPGvu1zDTErUB4J"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICauGhvnHIl4McMSsGnNGVpcg4fuqXC+CKqLeIN5BRjK"
  ];
  keys = sakuraba_keys;

  define7 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDbwWTEEz4csfPc3aEIvXIewjAQUoI8YgNpFrTJ/0G4";
  systems = [define7];
in {
  "passwordfile-sakuraba.age".publicKeys = keys ++ systems;
  "cachix-agent-token.age".publicKeys = keys ++ systems;
}
