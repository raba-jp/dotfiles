{ lib, pkgs, ... }:

let
  initFile = builtins.readFile ./init.lua;
  cmdKanaEngFile = builtins.readFile ./Spoons/CMDKanaEng.spoon/init.lua;
  ctrlMateFile = builtins.readFile ./Spoons/CtrlMate.spoon/init.lua;
in lib.mkIf (pkgs.stdenvNoCC.isDarwin) {
  xdg.configFile."hammerspoon/init.lua".text = initFile;
  xdg.configFile."hammerspoon/Spoons/CMDKanaEng.spoon/init.lua".text =
    cmdKanaEngFile;
  xdg.configFile."hammerspoon/Spoons/CtrlMate.spoon/init.lua".text =
    ctrlMateFile;

  # https://github.com/Hammerspoon/hammerspoon/pull/582
}
