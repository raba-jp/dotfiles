{
  lib,
  pkgs,
  ...
}: let
  initFile = builtins.readFile ./init.lua;
  cmdKanaEngFile = builtins.readFile ./Spoons/CMDKanaEng.spoon/init.lua;
  ctrlMateFile = builtins.readFile ./Spoons/CtrlMate.spoon/init.lua;
in
  lib.mkIf pkgs.stdenvNoCC.isDarwin {
    home.file = {
      ".hammerspoon/init.lua".text = initFile;
      ".hammerspoon/Spoons/CtrlMate.spoon/init.lua".text = ctrlMateFile;
    };
  }
