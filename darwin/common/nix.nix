{
  pkgs,
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  nix = {
    enable = true;
    settings = {
      trusted-users = ["root" "@wheel"];
      substituters = outputs.nixConfig.extra-substituers;
      trusted-public-keys = outputs.nixConfig.extra-trusted-public-keys;

      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = false;
      warn-dirty = false;
    };
  };
}
