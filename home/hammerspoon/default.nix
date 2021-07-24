{ pkgs, ... }:

let
  initFile = builtin.readFile ./init.lua;
  cmdKanaEngFile = builtin.readFile ./Spoons/CMDKanaEng.spoon/init.lua;
  ctrlMateFile = builtin.readFile ./Spoons/CtrlMate.spoon/init.lua;
in {
  xdg.configFile."hammerspoon/init.lua".text = initFile;
  xdg.configFile."hammerspoon/Spoons/CMDKanaEng.spoon/init.lua".text = cmdKanaEngFile;
  xdg.configFile."hammerspoon/Spoons/CtrlMate.spoon/init.lua".text = ctrlMateFile;

  # https://github.com/Hammerspoon/hammerspoon/pull/582
}
