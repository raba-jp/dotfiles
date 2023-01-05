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
      auto-optimise-store = lib.mkDefault true;
      warn-dirty = false;
    };

    package = pkgs.nix;

    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
