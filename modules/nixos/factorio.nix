{ lib, pkgs, ... }:
let
  userFile = builtins.readFile ../../secrets/factorio_username;
  tokenFile = builtins.readFile ../../secrets/factorio_token;
in lib.mkIf ((builtins.hashFile "sha256" ../../secrets/factorio_username)
  == "34fc592b9e318b3bc7931a26ebc6eef899990251eded749ec9a10e9d43cc7eda") {
    services.factorio = {
      enable = true;

      username = userFile;
      token = tokenFile;

      public = false;
    };
  }
