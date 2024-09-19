{
  pkgs,
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  nix = {
    settings = {
      trusted-users = ["root" "@wheel"];
      substituters = outputs.nixConfig.extra-substituers;
      trusted-public-keys = outputs.nixConfig.extra-trusted-public-keys;

      experimental-features = ["nix-command" "flakes" "repl-flake"];
      auto-optimise-store = false;
      warn-dirty = false;
    };
  };
}
