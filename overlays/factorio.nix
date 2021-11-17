final: prev:
let
  userFile = builtins.readFile ../secrets/factorio_username;
  tokenFile = builtins.readFile ../secrets/factorio_token;
in {
  factorio = prev.factorio.override {
    username = userFile;
    token = tokenFile;
  };
}
