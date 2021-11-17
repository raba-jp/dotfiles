{ lib, pkgs, ... }:
let
  userFile = builtins.readFile ../../secrets/factorio_username;
  tokenFile = builtins.readFile ../../secrets/factorio_token;
in lib.mkIf (builtins.pathExists ../../secrets/factorio_username) {
  services.factorio = {
    enable = true;

    username = userFile;
    token = tokenFile;

    public = false;
  };
}
